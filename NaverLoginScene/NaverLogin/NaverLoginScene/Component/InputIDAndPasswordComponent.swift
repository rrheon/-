//
//  InputIDAndPasswordComponent.swift
//  NaverLogin
//
//  Created by 최용헌 on 11/11/24.
//

import UIKit

protocol LoginButtonDelegate: AnyObject {
  /// 로그인 버튼의 활성화 여부 체크
  /// - Parameter activate: 활성화 여부
  func activateLoginButton(activate: Bool)
}


/// 로그인 실패 여부에 따른 로그인 버튼 UI 업데이트
protocol setupLoginButtonDelegate: AnyObject{
  func updateLoginButtonUI(height: CGFloat)
  func showLoginPopupView()
}

final class InputIDAndPasswordComponent: UIView{
  weak var loginButtonDelegate: LoginButtonDelegate?
  weak var setupLoignButtonDelegate: setupLoginButtonDelegate?

  let loginMockup: (id: String, password: String) = ("testID", "123456789")

  @IBOutlet weak var enterIDView: UIView!
  @IBOutlet weak var idTextField: UITextField!
  @IBOutlet weak var idPlaceHolderLabel: UILabel!
  @IBOutlet weak var idPlaceHolderTopAnchor: NSLayoutConstraint!
  
  @IBOutlet weak var textFieldUnderLine: UIView!
  
  @IBOutlet weak var enterPasswordView: UIView!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var passwordPlaceHolderLabel: UILabel!
  @IBOutlet weak var passwordPlaceHolderTopAnchor: NSLayoutConstraint!
  
  @IBOutlet weak var clearIDButton: UIButton!
  @IBOutlet weak var clearPasswordButton: UIButton!
  
  @IBOutlet weak var passwordHiddenButton: UIButton!
  
  var keyboardToolbar: KeyboardToolbar?
  
  // TODO: textfield 문자열 특수문자 입력가능, 이모티콘 1개입력되면 입력 중단시키기
    
  @IBOutlet weak var alertLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    changeTextFieldToID()
    
/// view의 특정 모서리 조절
    enterIDView.setupUIViewCornerRadius(
      leftCorner: .layerMinXMinYCorner,
      rightCorner: .layerMaxXMinYCorner
    )
    
    enterPasswordView.setupUIViewCornerRadius(
      leftCorner: .layerMinXMaxYCorner,
      rightCorner: .layerMaxXMaxYCorner
    )
    
    idTextField.delegate = self
    setupToolbar()
    idTextField.setPaddingInTextField()
    
    passwordTextField.delegate = self
    passwordTextField.setPaddingInTextField()
    
    passwordHiddenButton.isHidden = true
    clearIDButton.isHidden = true
    clearPasswordButton.isHidden = true
    alertLabel.isHidden = true
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    applyNib()
  }
  
  // MARK: - function
  
  /// password 숨기기 버튼 clicked
  /// - Parameter sender: password 숨기기 버튼
  @IBAction func onPasswordHidenButtonClicked(_ sender: UIButton) {
    passwordTextField.isSecureTextEntry.toggle()
    
    let buttonImage: String = passwordTextField.isSecureTextEntry ? "eye.slash": "eye"
    sender.setImage(UIImage(systemName: buttonImage), for: .normal)
  }
  
  /// TextField 의 내용 없애기
  /// - Parameter sender: 선택한 버튼
  @IBAction func onClearTextFieldButtonClicked(_ sender: UIButton) {
    switch sender{
    case clearIDButton:
      idTextField.text = .none
    case clearPasswordButton:
      passwordTextField.text = .none
    default:
      return
    }
    loginButtonDelegate?.activateLoginButton(activate: isIDAndPasswordEmpty())
  }
  
  
  /// 아이디/ 비밀먼호 textField 빈칸 체크
  /// - Returns: 빈칸 여부
  func isIDAndPasswordEmpty() -> Bool{
    return passwordTextField.text?.isEmpty == false && idTextField.text?.isEmpty == false
  }
  
  
  /// Toolbar 세팅
  func setupToolbar(){
    let leftButton1 = UIButton()
    leftButton1.setImage(UIImage(systemName: "chevron.left"), for: .normal)
    leftButton1.tintColor = .lightGray
    leftButton1.addTarget(self, action: #selector(changeTextFieldToID), for: .touchUpInside)
    
    let leftButton2 = UIButton()
    leftButton2.setImage(UIImage(systemName: "chevron.right"), for: .normal)
    leftButton2.tintColor = .lightGray
    leftButton2.addTarget(self, action: #selector(changeTextFieldToPassword), for: .touchUpInside)
    
    keyboardToolbar = KeyboardToolbar(leftBarButtons: [leftButton1, leftButton2])
    keyboardToolbar?.textFieldLine = textFieldUnderLine
    
    idTextField.inputAccessoryView = keyboardToolbar
    passwordTextField.inputAccessoryView = keyboardToolbar
  }
  
  
  /// Toolbar의 왼쪽 버튼  중 왼쪽 버튼 액션 - idTextField로 포커싱
  @objc func changeTextFieldToID() {
    idTextField.becomeFirstResponder()
  }
  
  /// Toolbar의 왼쪽 버튼 중 오른쪽 버튼 액션 - passwordTextField로 포커싱
  @objc func changeTextFieldToPassword() {
    passwordTextField.becomeFirstResponder()
  }
}

// MARK: - TextFieldDelegate extension
extension InputIDAndPasswordComponent: UITextFieldDelegate {
  
  /// textField의 글자 수 제한( ID: 20자 , password: 16자 )
  /// - Parameters:
  ///   - textField: 해당 textField
  ///   - range: 새로 입력하려는 문자열의 위치
  ///   - string: 새로 추가되는 문자열의 길이
  /// - Returns: 입력 가능 여부 반환
  func textField(
    _ textField: UITextField,
    shouldChangeCharactersIn range: NSRange,
    replacementString string: String
  ) -> Bool {
    let maxLength = textField == idTextField ? 20 : 16
    let currentText = textField.text ?? ""
    
    // 문자열의 전체 길이 계산
    let newLength = currentText.count + string.count - range.length
    return newLength <= maxLength
  }
  
  func textFieldDidChangeSelection(_ textField: UITextField) {
    
    // textField가 비어있지 않으면 clearButton 활성화
    let isTextFieldEmpty: Bool = textField.text?.isEmpty == true
    let clearButton: UIButton = textField == idTextField ? clearIDButton : clearPasswordButton
    clearButton.isHidden = isTextFieldEmpty

    if textField == passwordTextField {
      textField.isSecureTextEntry = true
      passwordHiddenButton.isHidden = isTextFieldEmpty
    }
    
    loginButtonDelegate?.activateLoginButton(activate: isIDAndPasswordEmpty())
  }
  
  /// textField 입력 시 placeHolder Label , textFieldBorder 세팅
  /// - Parameter textField: 해당 textField
  func textFieldDidBeginEditing(_ textField: UITextField) {
    // 선택된 textfield를 감싸는 view 선택
    let selectedView: UIView = textField == idTextField ? enterIDView : enterPasswordView
    
    // 선택된 view의 border 업데이트
    selectedView.updateUIViewBorder()
    
    // textfield들이 닿아있는 곳의 border 없애주기
    textFieldUnderLine.borderWidth = 0

    var placeHolderLabel: UILabel? = nil
    var topAnchor: NSLayoutConstraint? = nil
    
    // 변경할 placehoder 선택, 변경할 topAnchor 선택
    placeHolderLabel = textField == idTextField ? idPlaceHolderLabel : passwordPlaceHolderLabel
    topAnchor = textField == idTextField ? idPlaceHolderTopAnchor : passwordPlaceHolderTopAnchor
    
    guard let _placeHolderLabel = placeHolderLabel,
          let _topAnchor = topAnchor else { return }
    
    _placeHolderLabel.updateTextFieldHolder(target: self, fontSize: 12, _topAnchor, constant: 15)
  }
  
  
  /// textField 입력 종료 시 placeHolder Label , textFieldBorder 세팅
  /// - Parameter textField: 해당 textField
  func textFieldDidEndEditing(_ textField: UITextField) {
    let selectedView: UIView = textField == idTextField ? enterIDView : enterPasswordView
  
    selectedView.updateUIViewBorder(borderWidth: 1, borderColor: UIColor.lightGray.cgColor)
    
    let isEmpty: Bool = textField.text?.isEmpty == true
    
    switch textField {
    case idTextField where isEmpty:
      idPlaceHolderLabel.updateTextFieldHolder(target: self, idPlaceHolderTopAnchor)
    case passwordTextField where isEmpty:
      passwordPlaceHolderLabel.updateTextFieldHolder(target: self,passwordPlaceHolderTopAnchor)
    default:
      // textfield들이 닿아있는 곳의 border 만들어주기
      textFieldUnderLine.borderWidth = 1
    }
  }
  
  /// 키보드 다음/완료 버튼 터치 시
  /// - Parameter textField: 해당 textfield
  /// - Returns: <#description#>
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
    switch textField {
    case idTextField:
      changeTextFieldToPassword()
    case passwordTextField:
      onDoneButtonClicked()
    default:
      return true
    }
    return true
  }
  
  /// 로그인 버튼/ Done 버튼 클릭 시
  func onDoneButtonClicked(){
    let userID = idTextField.text
    let password = passwordTextField.text
    
    let loginValidationResult = LoginValidationCase.validate(
      id: userID ?? "",
      password: password ?? "",
      loginMockup: loginMockup
    )
    
    setupLoignButtonDelegate?.showLoginPopupView()
    
    switch loginValidationResult {
    case .idEmpty:
      idTextField.becomeFirstResponder()
      setupAlertLabel(message: AlertLabelContentCase.idError.message, height: 180)
    case .passwordEmpty:
      setupAlertLabel(message: AlertLabelContentCase.passwordError.message, height: 180)
    case .successToLogin:
      print(#fileID, #function, #line," - 로그인 성공")
    case .failToLogin:
      print(#fileID, #function, #line," - 로그인 실패")
      setupAlertLabel(message: AlertLabelContentCase.failToLogin.message, height: 200)
    }
    
  }
  
  
  /// 로그인 경고 라벨 설정
  /// - Parameters:
  ///   - hidden: 라벨 숨김 여부
  ///   - message: 메세지 내용
  ///   - height: 로그인 버튼과 라벨 사이의 공간
  func setupAlertLabel(hidden: Bool = false, message: String, height: CGFloat = 60){
    alertLabel.isHidden = hidden
    alertLabel.text = message
    setupLoignButtonDelegate?.updateLoginButtonUI(height: height)
  }
}

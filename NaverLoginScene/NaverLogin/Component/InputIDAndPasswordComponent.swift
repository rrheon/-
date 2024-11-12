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

final class InputIDAndPasswordComponent: UIView{
  weak var delegate: LoginButtonDelegate?
  
  @IBOutlet weak var idTextField: UITextField!
  @IBOutlet weak var idTextFieldPlaceHolderLabel: UILabel!
  @IBOutlet weak var idTextFieldPlaceHolderTopAnchor: NSLayoutConstraint!
  
  @IBOutlet weak var textFieldUnderLine: UIView!
  
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var passwordTextFieldPlaceHolderLabel: UILabel!
  @IBOutlet weak var passwordTextFieldPlaceHolderTopAnchor: NSLayoutConstraint!
  
  @IBOutlet weak var clearIDButton: UIButton!
  @IBOutlet weak var clearPasswordButton: UIButton!
  
  
  @IBOutlet weak var passwordHiddenButton: UIButton!
  
  // TODO: textfield 문자열 특수문자 입력가능, 이모티콘 1개입력되면 입력 중단시키기
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    // textField의 특정 모서리 조절
    idTextField.setupTextFieldCornerRadius(
      leftCorner: .layerMinXMinYCorner,
      rightCorner: .layerMaxXMinYCorner
    )
    
    passwordTextField.setupTextFieldCornerRadius(
      leftCorner: .layerMinXMaxYCorner,
      rightCorner: .layerMaxXMaxYCorner
    )
    
    idTextField.delegate = self
    idTextField.setPaddingInTextField()
    
    passwordTextField.delegate = self
    passwordTextField.setPaddingInTextField()

    textFieldUnderLine.backgroundColor = .systemGray6
    
    passwordHiddenButton.isHidden = true
    clearIDButton.isHidden = true
    clearPasswordButton.isHidden = true
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    applyNib()
  }
  
  
  /// password 숨기기 버튼 clicked
  /// - Parameter sender: password 숨기기 버튼
  @IBAction func onPasswordHidenButtonClicked(_ sender: UIButton) {
    passwordTextField.isSecureTextEntry.toggle()
  
    // 배경이 안바뀜
    let buttonImage: String = passwordTextField.isSecureTextEntry ? "eye.slash": "eye"
    print(#fileID, #function, #line," - \(buttonImage)")

    sender.setBackgroundImage(UIImage(systemName: buttonImage), for: .normal)
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
    delegate?.activateLoginButton(activate: isIDAndPasswordEmpty())
  }
  
  
  /// 아이디/ 비밀먼호 textField 빈칸 체크
  /// - Returns: 빈칸 여부
  func isIDAndPasswordEmpty() -> Bool{
    return passwordTextField.text?.isEmpty == false && idTextField.text?.isEmpty == false
  }
}

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
    
    delegate?.activateLoginButton(activate: isIDAndPasswordEmpty())
  }
  
  /// textField 입력 시 placeHolder Label , textFieldBorder 세팅
  /// - Parameter textField: 해당 textField
  func textFieldDidBeginEditing(_ textField: UITextField) {
    
    textField.updateTextFieldBorder()

    textFieldUnderLine.backgroundColor = .systemGray6

    var placeHolderLabel: UILabel? = nil
    var topAnchor: NSLayoutConstraint? = nil
    
    placeHolderLabel = textField == idTextField ? idTextFieldPlaceHolderLabel : passwordTextFieldPlaceHolderLabel
    topAnchor = textField == idTextField ? idTextFieldPlaceHolderTopAnchor : passwordTextFieldPlaceHolderTopAnchor
    
    guard let _placeHolderLabel = placeHolderLabel,
          let _topAnchor = topAnchor else { return }
    
    _placeHolderLabel.updateTextFieldHolder(target: self, fontSize: 12, _topAnchor, constant: 10)
  }
  
  
  /// textField 입력 종료 시 placeHolder Label , textFieldBorder 세팅
  /// - Parameter textField: 해당 textField
  func textFieldDidEndEditing(_ textField: UITextField) {
    textField.updateTextFieldBorder(borderWidth: 1, borderColor: UIColor.lightGray.cgColor)
    textFieldUnderLine.backgroundColor = .systemGray6

    if textField == idTextField && textField.text?.isEmpty == true {
      idTextFieldPlaceHolderLabel.updateTextFieldHolder(
        target: self,
        idTextFieldPlaceHolderTopAnchor
      )
    }else if textField == passwordTextField && textField.text?.isEmpty == true{
      passwordTextFieldPlaceHolderLabel.updateTextFieldHolder(
        target: self,
        passwordTextFieldPlaceHolderTopAnchor
      )
    }
  }
}

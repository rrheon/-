//
//  InputIDAndPasswordComponent.swift
//  NaverLogin
//
//  Created by 최용헌 on 11/11/24.
//

import UIKit

final class InputIDAndPasswordComponent: UIView {
  @IBOutlet weak var idTextField: UITextField!
  @IBOutlet weak var idTextFieldPlaceHolderLabel: UILabel!
  @IBOutlet weak var idTextFieldPlaceHolderTopAnchor: NSLayoutConstraint!
  
  @IBOutlet weak var textFieldUnderLine: UIView!
  
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var passwordTextFieldPlaceHolderLabel: UILabel!
  @IBOutlet weak var passwordTextFieldPlaceHolderTopAnchor: NSLayoutConstraint!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    applyNib()
    
    idTextField.setupTextFieldCornerRadius(leftCorner: .layerMinXMinYCorner, rightCorner: .layerMaxXMinYCorner)
    passwordTextField.setupTextFieldCornerRadius(leftCorner: .layerMinXMaxYCorner, rightCorner: .layerMaxXMaxYCorner)
    
    idTextField.delegate = self
    passwordTextField.delegate = self
    textFieldUnderLine.backgroundColor = .systemGray6
    
    idTextField.clearButtonMode = .whileEditing
  }
  
  required override init(frame: CGRect) {
    super.init(frame: frame)
    applyNib()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
}

extension InputIDAndPasswordComponent: UITextFieldDelegate {
  
  /// textField 입력 시 placeHolder Label , textFieldBorder 세팅
  /// - Parameter textField: 해당 textField
  func textFieldDidBeginEditing(_ textField: UITextField) {
    
    updateTextFieldBorder(textField)
    var placeHolderLabel: UILabel? = nil
    var topAnchor: NSLayoutConstraint? = nil
    
    placeHolderLabel = textField == idTextField ? idTextFieldPlaceHolderLabel : passwordTextFieldPlaceHolderLabel
    topAnchor = textField == idTextField ? idTextFieldPlaceHolderTopAnchor : passwordTextFieldPlaceHolderTopAnchor
    
    guard let _placeHolderLabel = placeHolderLabel,
          let _topAnchor = topAnchor else { return }
    
    updateTextFieldHolder(_placeHolderLabel, fontSize: 12, _topAnchor, constant: 5)
  }
  
  
  /// textField 입력 종료 시 placeHolder Label , textFieldBorder 세팅
  /// - Parameter textField: 해당 textField
  func textFieldDidEndEditing(_ textField: UITextField) {
    updateTextFieldBorder(textField, borderWidth: 1, borderColor: UIColor.lightGray.cgColor)
    
    if textField == idTextField && textField.text?.isEmpty == true {
      updateTextFieldHolder(idTextFieldPlaceHolderLabel, idTextFieldPlaceHolderTopAnchor)
    }else if textField == passwordTextField && textField.text?.isEmpty == true{
      updateTextFieldHolder(passwordTextFieldPlaceHolderLabel, passwordTextFieldPlaceHolderTopAnchor)
    }
  }
  
  
  /// TextField의 Border조절
  /// - Parameters:
  ///   - textField: 해당 textField
  ///   - borderWidth: border의 width
  ///   - borderColor: border의 color
  func updateTextFieldBorder(
    _ textField: UITextField,
    borderWidth: CGFloat = 4,
    borderColor: CGColor = UIColor.systemGreen.cgColor
  ){
    textField.layer.borderWidth = borderWidth
    textField.layer.borderColor = borderColor
    textFieldUnderLine.backgroundColor = .systemGray6
  }
  
  /// TextField의 placeHolder  Label 동적 조절
  /// - Parameters:
  ///   - placeHdolerLabel: placeHolder로 사용할 라벨
  ///   - fontSize: 라벨의 폰트사이즈
  ///   - topAnchor: 라벨의 topAnchor(TextField로 부터)
  ///   - constant:topAnchor 수치
  func updateTextFieldHolder(
    _ placeHdolerLabel: UILabel,
    fontSize: CGFloat = 17,
    _ topAnchor: NSLayoutConstraint,
    constant: CGFloat = 20
  ){
    placeHdolerLabel.font = .systemFont(ofSize: fontSize)
    topAnchor.constant = constant
    UIView.animate(withDuration: 0.3) {
      self.layoutIfNeeded()
    }
  }
}


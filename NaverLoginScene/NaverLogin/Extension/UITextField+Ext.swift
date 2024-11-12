//
//  UITextField+Ext.swift
//  NaverLogin
//
//  Created by 최용헌 on 11/11/24.
//

import UIKit

extension UITextField {
  
  /// textField의 특정 모서리 둥글게 만들기
  /// - Parameters:
  ///   - textField: 해당 textField
  ///   - leftCorner: 왼쪽 코너
  ///   - rightCorner: 오른쪽 코너
  func setupTextFieldCornerRadius(
    cornerRadious: CGFloat = 8,
    leftCorner: CACornerMask,
    rightCorner: CACornerMask
  ){
    self.layer.cornerRadius = cornerRadious
    self.layer.maskedCorners = CACornerMask(arrayLiteral: leftCorner, rightCorner)
  }
  
  /// TextField의 Border 색상, 두께 조절
  /// - Parameters:
  ///   - textField: 해당 textField
  ///   - borderWidth: border의 width
  ///   - borderColor: border의 color
  func updateTextFieldBorder(
    borderWidth: CGFloat = 4,
    borderColor: CGColor = UIColor.systemGreen.cgColor
  ){
    self.layer.borderWidth = borderWidth
    self.layer.borderColor = borderColor
  }
  
  
  /// textField에 padding 주기
  /// - Parameters:
  ///   - width: padding 의 가로 크기
  ///   - isLeftPadding: textField의 왼쪽에 padding 적용 여부
  ///   - isRightPadding: textField의 오른에 padding 적용 여부
  func setPaddingInTextField(
    width: CGFloat = 3,
    isLeftPadding: Bool = true,
    isRightPadding: Bool = true
  ){
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: frame.height))
    
    if isLeftPadding {
      leftView = paddingView
      leftViewMode = ViewMode.always
    }else if isRightPadding {
      rightView = paddingView
      rightViewMode = ViewMode.always
    }
  }
}

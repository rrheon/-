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
    _ textField: UITextField,
    cornerRadious: CGFloat = 8,
    leftCorner: CACornerMask,
    rightCorner: CACornerMask
  ){
    textField.layer.cornerRadius = cornerRadious
    textField.layer.maskedCorners = CACornerMask(arrayLiteral: leftCorner, rightCorner)
  }
}

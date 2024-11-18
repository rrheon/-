//
//  UITextField+Ext.swift
//  NaverLogin
//
//  Created by 최용헌 on 11/11/24.
//

import UIKit

extension UITextField {
  
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

//
//  UILabel+Ext.swift
//  NaverLogin
//
//  Created by 최용헌 on 11/12/24.
//

import UIKit

extension UILabel {
  
  /// TextField의 placeHolder  Label 동적 조절
  /// - Parameters:
  ///   - target: 제약조건 업데이트 후 animate 효과를 줄 view
  ///   - fontSize: 라벨의 폰트사이즈
  ///   - topAnchor: 라벨의 topAnchor(TextField로 부터)
  ///   - constant:topAnchor 수치
  func updateTextFieldHolder(
    target: UIView,
    fontSize: CGFloat = 17,
    _ topAnchor: NSLayoutConstraint,
    constant: CGFloat = 25
  ){
    self.font = .systemFont(ofSize: fontSize)
    topAnchor.constant = constant
    UIView.animate(withDuration: 0.3) {
      target.layoutIfNeeded()
    }
  }
}

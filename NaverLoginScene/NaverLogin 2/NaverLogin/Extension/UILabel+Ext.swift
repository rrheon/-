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
  
  
  /// 라벨의 특정 부분 색상/폰트 변경
  /// - Parameters:
  ///   - wantToChange:변경하려는 문자
  ///   - color: 변경하려는 색상
  ///   - font: 변경하려는 폰트
  func changeColor(
    wantToChange: String,
    color: UIColor,
    font: UIFont? = nil
  ) {
    guard let originalText = self.attributedText?.mutableCopy() as? NSMutableAttributedString else { return }
    
    let range = (originalText.string as NSString).range(of: wantToChange)
    
    if range.location != NSNotFound {
      originalText.addAttribute(.foregroundColor, value: color, range: range)
      
      if let font = font {
        originalText.addAttribute(.font, value: font, range: range)
      }
    
      self.attributedText = originalText
    }
  }
}

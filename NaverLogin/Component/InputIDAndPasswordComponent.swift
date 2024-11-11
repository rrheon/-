//
//  InputIDAndPasswordComponent.swift
//  NaverLogin
//
//  Created by 최용헌 on 11/11/24.
//

import UIKit

final class InputIDAndPasswordComponent: UIView {
  override func awakeFromNib() {
    super.awakeFromNib()
    applyNib()
  }
  
  required override init(frame: CGRect) {
    super.init(frame: frame)
    applyNib()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

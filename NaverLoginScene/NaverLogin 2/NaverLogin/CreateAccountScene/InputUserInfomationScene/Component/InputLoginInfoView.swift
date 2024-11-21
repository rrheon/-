//
//  InputLoginInfoView.swift
//  NaverLogin
//
//  Created by 최용헌 on 11/21/24.
//

import UIKit

final class InputLoginInfoView: UIView {
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    applyNib()
  }
  
  required init?(coder: NSCoder) {

    super.init(coder: coder)
    applyNib()
  }
}

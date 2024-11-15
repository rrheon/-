//
//  BottomViewComponent.swift
//  NaverLogin
//
//  Created by 최용헌 on 11/15/24.
//

import UIKit

final class BottomViewComponent: UIView {
  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    applyNib()
  }
  
  convenience init(){
    self.init(frame: .zero)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    applyNib()
  }
}

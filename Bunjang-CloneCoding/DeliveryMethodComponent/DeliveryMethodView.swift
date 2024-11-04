//
//  DeliveryMethodView.swift
//  Bunjang-CloneCoding
//
//  Created by 최용헌 on 11/4/24.
//

import UIKit

final class DeliveryMethodView: CustomView {
  override func awakeFromNib() {
    super.awakeFromNib()
    applyNib()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}

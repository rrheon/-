//
//  ItemSizeViewComponent.swift
//  Bunjang-CloneCoding
//
//  Created by 최용헌 on 11/8/24.
//

import UIKit

final class ItemSizeViewComponent: CustomView {
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

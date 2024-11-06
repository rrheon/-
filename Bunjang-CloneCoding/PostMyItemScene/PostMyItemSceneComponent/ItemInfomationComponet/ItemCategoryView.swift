//
//  ItemCategoryView.swift
//  Bunjang-CloneCoding
//
//  Created by 최용헌 on 11/4/24.
//

import UIKit

final class ItemCategoryView: CustomView {

  @IBOutlet weak var itemCategory1Button: UIButton!
  @IBOutlet weak var itemCategory2Button: UIButton!
  @IBOutlet weak var itemCategory3Button: UIButton!
  @IBOutlet weak var itemCategory4Button: UIButton!

  @IBOutlet weak var itemCategory1Label: UILabel!
  @IBOutlet weak var itemCategory2Label: UILabel!
  @IBOutlet weak var itemCategory3Label: UILabel!
  @IBOutlet weak var itemCategory4Label: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}

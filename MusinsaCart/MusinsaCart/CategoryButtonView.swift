//
//  CategoryButtonView.swift
//  MusinsaCart
//
//  Created by 최용헌 on 11/26/24.
//

import UIKit

final class CategoryButtonView: UIImageView {

  @IBOutlet weak var categoryLabel: UILabel!
  @IBOutlet weak var underLineView: UIView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    applyNib()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    applyNib()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    fatalError("init(coder:) has not been implemented")
  }
  
  convenience init(categoryName: String = "", btnSelected: Bool = false) {
    self.init(frame: .zero)
    
    self.categoryLabel.text = categoryName
    self.categoryLabel.textColor = btnSelected ? UIColor.white : UIColor.lightGray
    self.underLineView.isHidden = !btnSelected
  }
}

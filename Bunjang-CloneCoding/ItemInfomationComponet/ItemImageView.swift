//
//  ItemImageView.swift
//  Bunjang-CloneCoding
//
//  Created by 최용헌 on 11/2/24.
//

import UIKit

final class ItemImageView: CustomView {
  
  @IBOutlet weak var itemImageView: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    print(#fileID, #function, #line," - ")
    applyNib()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    print(#fileID, #function, #line," - ")
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    print(#fileID, #function, #line," - ")
  }
  
  convenience init(imageName: String){
    self.init(frame: .zero)
    self.itemImageView.image = UIImage(systemName: imageName)
  }
}

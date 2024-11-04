//
//  ItemImageView.swift
//  Bunjang-CloneCoding
//
//  Created by 최용헌 on 11/2/24.
//

import UIKit

final class ItemImageView: CustomView {
  
  @IBOutlet weak var itemImageView: UIImageView!
  
  
  var imageName: String = "" {
    didSet {
      DispatchQueue.main.async {
        self.itemImageView.image = UIImage(systemName: self.imageName)
      }
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    print(#fileID, #function, #line," - ")
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    print(#fileID, #function, #line," - ")
  }
  
  convenience init(imageName: String){
    self.init(frame: .zero)
    self.imageName = imageName
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    fatalError("init(coder:) has not been implemented")
  }
}

//
//  ItemImageView.swift
//  Bunjang-CloneCoding
//
//  Created by 최용헌 on 11/2/24.
//

import UIKit

final class ItemImageView: CustomView {
  
  @IBOutlet weak var itemImageView: UIImageView!
  @IBOutlet weak var removeItemImageButton: UIButton!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    removeItemImageButton.addTarget(self, action: #selector(onRemoveButtonClicked), for: .touchUpInside)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  
  /// 이미지 주입
  /// - Parameter imageName: 주입할 이미지
  convenience init(imageName: String = "star"){
    self.init(frame: .zero)
    
    DispatchQueue.main.async {
      self.itemImageView.image = UIImage(systemName: imageName)
    }
    
    removeItemImageButton.addTarget(self, action: #selector(onRemoveButtonClicked), for: .touchUpInside)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    fatalError("init(coder:) has not been implemented")
  }
  
  
  /// 상품이미지 삭제
  /// - Parameter sender: 해당 상품의 버튼
  @objc func onRemoveButtonClicked(sender: UIButton){
    self.isHidden = true
  }
}

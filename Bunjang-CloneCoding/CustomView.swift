//
//  CustomView.swift
//  Bunjang-CloneCoding
//
//  Created by 최용헌 on 11/2/24.
//

import UIKit

class CustomView: UIView {
  
  override func awakeFromNib() {
    super.awakeFromNib()
    applyNib()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    applyNib()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  func applyNib(){
    let nibName = String(describing: Self.self)
    let nib = Bundle.main.loadNibNamed(nibName, owner: self)
    guard let view = nib?.first as? UIView else { return }
    
    addSubview(view)
    view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      view.topAnchor.constraint(equalTo: self.topAnchor),
      view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      view.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      view.trailingAnchor.constraint(equalTo: self.trailingAnchor)
    ])
  }

}

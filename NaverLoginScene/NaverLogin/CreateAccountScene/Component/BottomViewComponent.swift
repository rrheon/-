//
//  BottomViewComponent.swift
//  NaverLogin
//
//  Created by 최용헌 on 11/15/24.
//

import UIKit


/// bottomView Delegate
protocol BottomViewDelegate: AnyObject {
  func onDismissButtonCliked()
}

final class BottomViewComponent: UIView {

  weak var delegate: BottomViewDelegate?
  
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
  
  
  @IBAction func onDismissButtonClicked(_ sender: Any) {
    delegate?.onDismissButtonCliked()
  }
}

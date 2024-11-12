//
//  ToolBar.swift
//  Bunjang-CloneCoding
//
//  Created by 최용헌 on 11/5/24.
//

import UIKit

final class KeyboardToolbar: UIToolbar {
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  convenience init(leftBarButton: UIView? = nil, rightBarButton: UIView? = nil ){
    self.init(frame: .zero)
    
    var barButtons = [UIBarButtonItem]()
    
    if let tmpLeftBarButton = leftBarButton {
      let leftButton = UIBarButtonItem(customView: tmpLeftBarButton)
      barButtons.append(leftButton)
    }
    
    if let tmpRightBarButton = rightBarButton {
      let rightButton = UIBarButtonItem(customView: tmpRightBarButton)
      barButtons.append(rightButton)
    }
    
    self.items = barButtons
    self.sizeToFit()
  }
}


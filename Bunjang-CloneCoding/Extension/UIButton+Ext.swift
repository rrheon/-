//
//  UIButton+Ext.swift
//  Bunjang-CloneCoding
//
//  Created by 최용헌 on 11/5/24.
//

import UIKit

extension UIButton {
  
  @IBInspectable var categoryTitle: String {
    get {
      return self.title(for: .normal) ?? ""
    }
    set {
      setTitle(newValue, for: .normal)
    }
  }
  
  @IBInspectable var categoryTitleColor: UIColor {
    get {
      return self.titleColor(for: .normal) ?? .black
    }
    set {
      setTitleColor(newValue, for: .normal)
    }
  }
}

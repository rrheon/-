//
//  UICollectionView+Ext.swift
//  week-10
//
//  Created by 최용헌 on 12/30/24.
//

import UIKit

extension UICollectionView {
  
  /// Nib 등록
  /// - Parameter withNib: NibID
  func register(withNib : String) {
    let cellNib = UINib(nibName: withNib, bundle: nil)
    self.register(cellNib, forCellWithReuseIdentifier: withNib)
  }
}

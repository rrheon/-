//
//  BottomSheetViewController.swift
//  Bunjang-CloneCoding
//
//  Created by 최용헌 on 11/7/24.
//

import UIKit

import PanModal

final class BottomSheetViewController: UITableViewController {
  
  
  @IBOutlet weak var sizeUnderLineView: UIView!
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.removeFromSuperview()
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.8)
    
    sizeUnderLineView.isHidden = true
  }
}

extension BottomSheetViewController: PanModalPresentable {
  var panScrollable: UIScrollView? {
    return tableView
  }
  
  var showDragIndicator: Bool {
    return false
  }
}

//
//  PopupView.swift
//  Bunjang-CloneCoding
//
//  Created by 최용헌 on 11/6/24.
//

import UIKit

final class PopupViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.8)
  }
  
  @IBAction func onChagneCategoryButtonClicked(_ sender: Any) {
    ViewModel.shared.changeCategoryButtonTapped.send(true)
    self.view.removeFromSuperview()
  }
  
  @IBAction func onCancelButtonClicked(_ sender: Any) {
    self.view.removeFromSuperview()
  }
}

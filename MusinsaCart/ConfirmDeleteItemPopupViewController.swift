//
//  ConfirmDeleteItemPopupView.swift
//  MusinsaCart
//
//  Created by 최용헌 on 11/27/24.
//

import UIKit

final class ConfirmDeleteItemPopupViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
  }
  
  
  @IBAction func onCancelBtnClicked(_ sender: Any) {
    self.dismiss(animated: true)
  }
  
  
  @IBAction func onDeleteBtnClicked(_ sender: Any) {
    print(#fileID, #function, #line," - 삭제탭")

  }
}

//
//  SuccessToLoginViewController.swift
//  NaverLogin
//
//  Created by 최용헌 on 11/19/24.
//

import UIKit

final class SuccessToLoginViewController: UIViewController {
  lazy var userID: String? = nil
  
  @IBOutlet weak var toastPopupLabel: UILabel!
  @IBOutlet weak var toastPopupView: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
      if let _userID = self.userID {
        self.toastPopupLabel.text = _userID + "아이디로 로그인 성공"
        self.toastPopupView.borderColor = .systemBlue
        self.toastPopupView.backgroundColor = .systemBlue
      }
      
      UIView.animate(withDuration: 3.0, delay: 0.1,options: .curveEaseOut, animations: {
        self.toastPopupView.alpha = 0.0
      }, completion: {(isCompleted) in
        self.toastPopupView.removeFromSuperview()
      })
    }
  }
}

//
//  ViewController.swift
//  NaverLogin
//
//  Created by 최용헌 on 11/11/24.
//

import UIKit

class ViewController: UIViewController{
  
  @IBOutlet weak var idAndPasswordView: InputIDAndPasswordComponent!
  @IBOutlet weak var loginButtonView: NaverLoginButton!
  
  // 화면이 나타날 때 Notification등록
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    // 키보드가 올라갔다는 것을 감지
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(keyboardWillShow),
      name: UIResponder.keyboardWillShowNotification,
      object: nil
    )
    // 키보드가 내려갔다는 것을 감지
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(keyboardWillHide),
      name: UIResponder.keyboardWillHideNotification,
      object: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    view.backgroundColor = .white
    
    idAndPasswordView.loginButtonDelegate = loginButtonView
    idAndPasswordView.keyboardToolbar?.toolbarDelegate = self
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    // 화면이 사라질 때 등록한 Notification 제거
    NotificationCenter.default.removeObserver(
      self,
      name: UIResponder.keyboardWillShowNotification,
      object: nil
    )
    
    NotificationCenter.default.removeObserver(
      self,
      name: UIResponder.keyboardWillHideNotification,
      object: nil
    )
  }
  
  
  @IBAction func onCreateAccountBtnClicked(_ sender: Any) {
    performSegue(withIdentifier: "AgreementViewController", sender: sender)
  }
  
  
  /// 키보드가 올라가고 내려갈 때 UI조절
  /// - Parameter height: 키보드 높이
  @objc func updateUIWithKeyboard(height: CGFloat = 0){
    UIView.animate(withDuration: 0.3) {
      // 구조체 함수를 이용해서 뷰를 움직인다
      let transform = CGAffineTransform(translationX: 0, y: height)
      self.view.transform = transform
    }
  }
  
  @objc func keyboardWillShow(notification : NSNotification) {
    updateUIWithKeyboard(height: -110)
  }
  
  @objc func keyboardWillHide(notification : NSNotification) {
    updateUIWithKeyboard(height: 0)
  }
  
  
}

extension ViewController: KeyboardToolbarDelegate {
  func onCloseButtonClicked() {
    self.view.endEditing(true)
  }
}

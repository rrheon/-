//
//  ViewController.swift
//  NaverLogin
//
//  Created by 최용헌 on 11/11/24.
//

import UIKit

class ViewController: UIViewController{
  
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var idAndPasswordView: InputIDAndPasswordComponent!
  @IBOutlet weak var loginButtonView: NaverLoginButton!
  
  @IBOutlet weak var idAndPasswordViewHeight: NSLayoutConstraint!
  
  @IBOutlet weak var checkIsScrollView: UIView!
  
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
    idAndPasswordView.setupLoignButtonDelegate = self
    
    loginButtonView.loginButtonTapped = idAndPasswordView.onDoneButtonClicked
    
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
  
  
  /// 키보드가 올라가고 내려갈 때 스크롤 여부 설정
  @objc func keyboardWillShow(notification : NSNotification) {
    scrollView.isScrollEnabled = true
  }
  
  @objc func keyboardWillHide(notification : NSNotification) {
    scrollView.isScrollEnabled = false
  }
}

extension ViewController: KeyboardToolbarDelegate, setupLoginButtonDelegate {
  func updateLoginButtonUI(height: CGFloat = 180) {
    idAndPasswordViewHeight.constant = height
    
//    loginButtonViewTopAnchor.constant = height
  }
  
  func showLoginPopupView() {
    let loginPopupView: UIViewController = LoginPopupViewController()
    loginPopupView.modalPresentationStyle = .overFullScreen
    self.present(loginPopupView, animated: true) {
      DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
        loginPopupView.dismiss(animated: true, completion: nil)
      }
    }
  }
  
  func onCloseButtonClicked() {
    self.view.endEditing(true)
  }
}

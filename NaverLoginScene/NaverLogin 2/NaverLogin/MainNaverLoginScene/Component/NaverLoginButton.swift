//
//  NaverLoginButton.swift
//  NaverLogin
//
//  Created by 최용헌 on 11/12/24.
//

import UIKit

final class NaverLoginButton: UIView {
  @IBOutlet weak var naverLoginButton: UIButton!
  
  var loginButtonTapped: (() -> Void)? = nil
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    activateLoginButton(activate: false)
    naverLoginButton.layer.cornerRadius = 8
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    applyNib()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    applyNib()
  }
  
  convenience init(title: String = "") {
    self.init(frame: .zero)
    
    DispatchQueue.main.async {
      self.naverLoginButton.setTitle(title, for: .normal)
    }
  }
  

  // TODO: 로그인 버튼을 눌렀을 때 성공 / 에러처리
  @IBAction func onLoginButtonClicked(_ sender: Any) {
    print(#fileID, #function, #line," - 로그인 버튼 탭")
    if let _loginButtonTapped = loginButtonTapped {
      _loginButtonTapped()
    }
  }
}

extension NaverLoginButton: LoginButtonDelegate {
  /// 버튼의 색상 및 버튼 활성화 설정
  /// - Parameter activate: 활성화 여부
  func activateLoginButton(activate: Bool) {
    
    // 버튼 활성화 여부에 따라 배경색과 텍스트 색상 설정
    naverLoginButton.backgroundColor = activate ? .activateButtonColor : .unActivateButtonColor
    naverLoginButton.isEnabled = activate
  }
}

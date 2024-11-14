//
//  NaverLoginButton.swift
//  NaverLogin
//
//  Created by 최용헌 on 11/12/24.
//

import UIKit

final class NaverLoginButton: UIView {
  @IBOutlet weak var naverLoginButton: UIButton!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    activateLoginButton(activate: false)
    naverLoginButton.layer.cornerRadius = 8
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    applyNib()
  }
  
  @IBAction func onLoginButtonClicked(_ sender: Any) {
    print(#fileID, #function, #line," - 로그인 버튼 탭")
  }
}

extension NaverLoginButton: LoginButtonDelegate {
  /// 버튼의 색상 및 버튼 활성화 설정
  /// - Parameter activate: 활성화 여부
  func activateLoginButton(activate: Bool) {
    print(#fileID, #function, #line, " - \(activate)")
    
    // 버튼 활성화 여부에 따라 배경색과 텍스트 색상 설정
    naverLoginButton.backgroundColor = activate ? .activateButtonColor : .unActivateButtonColor
    naverLoginButton.isEnabled = activate
  }
}

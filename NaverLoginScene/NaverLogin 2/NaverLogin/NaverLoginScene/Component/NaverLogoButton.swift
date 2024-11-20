//
//  NaverLogoButton.swift
//  NaverLogin
//
//  Created by 최용헌 on 11/12/24.
//

import UIKit

final class NaverLogoButton: UIView {
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    applyNib()
  }
  
  @IBAction func onNaverLogoButtonClicked(_ sender: Any) {
    print(#fileID, #function, #line," - 네이버 홈으로 이동")

  }
}

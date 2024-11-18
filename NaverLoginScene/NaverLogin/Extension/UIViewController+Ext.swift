//
//  UIViewController+Ext.swift
//  NaverLogin
//
//  Created by 최용헌 on 11/18/24.
//

import UIKit

import Lottie

extension UIViewController{
  func setViewAndGif(showView : UIView , jsonName : String){
    let animationLoti = LottieAnimationView.init(name: jsonName)
    
    showView.addSubview(animationLoti)
    animationLoti.frame = showView.bounds
    animationLoti.contentMode = .scaleAspectFit
    
    animationLoti.translatesAutoresizingMaskIntoConstraints = true
    NSLayoutConstraint.activate([
      animationLoti.widthAnchor.constraint(equalTo: showView.widthAnchor),
      animationLoti.heightAnchor.constraint(equalTo: showView.heightAnchor)
    ])
    
    animationLoti.play()// 애니메이션 시작
    animationLoti.loopMode = .loop // 루프 돌기
    animationLoti.animationSpeed = 1.5 // 재생 속도
    animationLoti.backgroundBehavior = .pauseAndRestore // 화면이 안보이는 상태일때 어떻게 할껀지
  }
}

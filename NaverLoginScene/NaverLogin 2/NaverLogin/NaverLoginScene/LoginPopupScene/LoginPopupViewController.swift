//
//  LoginPopupViewController.swift
//  NaverLogin
//
//  Created by 최용헌 on 11/18/24.
//

import UIKit

import Lottie

final class LoginPopupViewController: UIViewController {
  private lazy var popupView: UIView = UIView()
  private lazy var loginLabel: UILabel = {
    let label = UILabel()
    label.text = "로그인 중 입니다."
    label.textColor = .black
    label.font = .systemFont(ofSize: 20)
    label.textAlignment = .center
    return label
  }()
  
  private lazy var lottieView: UIView = UIView()
  
  let animationView: LottieAnimationView = {
    let aniView = LottieAnimationView(name: "LoadingAnimation")
    aniView.frame = CGRect(x: 0, y: 0, width: 300, height: 100)
    aniView.contentMode = .scaleAspectFill
    return aniView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
    
    view.addSubview(popupView)
    popupView.translatesAutoresizingMaskIntoConstraints = false
    popupView.backgroundColor = .white
    popupView.layer.cornerRadius = 10
    popupView.layer.masksToBounds = true
    NSLayoutConstraint.activate([
      popupView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      popupView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
      popupView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
      popupView.heightAnchor.constraint(equalToConstant: 130)
    ])
    
    popupView.addSubview(loginLabel)
    loginLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      loginLabel.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 10),
      loginLabel.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -10),
      loginLabel.topAnchor.constraint(equalTo: popupView.topAnchor, constant: 20),
      loginLabel.heightAnchor.constraint(equalToConstant: 20)
    ])
    
    popupView.addSubview(animationView)
    
    animationView.play()
    // 루프 돌기
    animationView.loopMode = .loop
    // 재생 속도
    animationView.animationSpeed = 1.5
    
    animationView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      animationView.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 30),
      animationView.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 10),
      animationView.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -10),
      animationView.heightAnchor.constraint(equalToConstant: 50)
    ])
  }
}

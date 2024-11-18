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
      popupView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
      popupView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
      popupView.heightAnchor.constraint(equalToConstant: 120)
    ])
    
    popupView.addSubview(loginLabel)
    loginLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      loginLabel.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 10),
      loginLabel.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -10),
      loginLabel.topAnchor.constraint(equalTo: popupView.topAnchor, constant: 0)
    ])
    

    popupView.addSubview(lottieView)
    lottieView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
          lottieView.centerXAnchor.constraint(equalTo: popupView.centerXAnchor),
          lottieView.centerYAnchor.constraint(equalTo: popupView.centerYAnchor),
          lottieView.widthAnchor.constraint(equalTo: popupView.widthAnchor, multiplier: 0.8),
          lottieView.heightAnchor.constraint(equalTo: popupView.heightAnchor, multiplier: 0.8)
      ])
    
    setViewAndGif(showView: lottieView, jsonName: "LoadingAnimation")
  }
}

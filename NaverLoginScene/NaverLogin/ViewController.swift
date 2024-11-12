//
//  ViewController.swift
//  NaverLogin
//
//  Created by 최용헌 on 11/11/24.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var idAndPasswordView: InputIDAndPasswordComponent!
  
  @IBOutlet weak var loginButtonView: NaverLoginButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    idAndPasswordView.delegate = loginButtonView
    
  }
}

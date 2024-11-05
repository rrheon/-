//
//  ViewController.swift
//  Bunjang-CloneCoding
//
//  Created by 최용헌 on 11/2/24.
//

import UIKit

class ViewController: UIViewController  {

  @IBOutlet weak var itemInfomationView: ItemInfomationView!
  
  @IBOutlet weak var itemInfomationViewHeightAnchor: NSLayoutConstraint!
  
  @IBOutlet weak var scrollView: UIScrollView!
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    setupDelegate()
  }
  
  func setupDelegate(){
    itemInfomationView.delegate = self
    scrollView.delegate = self
  }
}

extension ViewController: UIScrollViewDelegate {
  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    view.endEditing(true)
  }
}

extension ViewController: ItemInfomationViewDelegate {
  func updateViewConstraint(height: CGFloat) {
    itemInfomationViewHeightAnchor.constant = height
  }
}

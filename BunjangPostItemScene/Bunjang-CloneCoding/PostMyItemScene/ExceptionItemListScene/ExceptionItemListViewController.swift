//
//  ExceptionItemListViewController.swift
//  Bunjang-CloneCoding
//
//  Created by 최용헌 on 11/6/24.
//

import UIKit

final class ExceptionItemListViewController: UIViewController{
  
  
  @IBOutlet weak var progressView: UIProgressView!
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var titleLabel: UILabel!
  
  @IBOutlet weak var popButton: UIButton!
  
  var time: Float = 0.0
  var timer: Timer?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.setHidesBackButton(true, animated: true)

    titleLabel.isHidden = true
    
    scrollView.delegate = self
    
    timer?.invalidate()
    timer = Timer.scheduledTimer(timeInterval: 0.05,
                                 target: self,
                                 selector: #selector(setProgress),
                                 userInfo: nil,
                                 repeats: true)
    progressView.progress = 0
    
    popButton.addTarget(self, action: #selector(moveToPostItemVC), for: .touchUpInside)
  }
  
  @objc func setProgress(){
    time += 0.1
    progressView.setProgress(time, animated: true)
    if time > 1.0 {
      timer?.invalidate()
      progressView.isHidden = true
    }
  }
  
  @IBAction func navToPostItemVC(_ sender: Any) {
    moveToPostItemVC()
  }
  
  @objc func moveToPostItemVC(){
    self.navigationController?.popViewController(animated: true)
  }
}

extension ExceptionItemListViewController: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    print(#fileID, #function, #line," - \(scrollView.contentOffset.y)")
    
    let currentOffsetY = scrollView.contentOffset.y
    
    
    // TODO: underline위치 이하면 숨기고 이상이면 title label 보이기 - 83
    
    let labelHidden = currentOffsetY < 83 ? true : false
    titleLabel.isHidden = labelHidden

  }
}

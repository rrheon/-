//
//  PostDetailVC.swift
//  week-10
//
//  Created by 최용헌 on 12/18/24.
//

import UIKit

class PostDetailVC: UIViewController {
  
  var onAddPostAction: (() -> Void)? = nil
  var onDeletePostAction: (() -> Void)? = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  
  /// 현재 게시글 삭제 버튼 클릭
  /// - Parameter sender: 삭제버튼
  @IBAction func onDeletePostBtnClicked(_ sender: UIButton) {
    if let action = onDeletePostAction {
      action()
      self.navigationController?.popViewController(animated: true)
    }
  }
  
  
  /// 게시글 추가 버튼 클릭
  /// - Parameter sender: 추가버튼
  @IBAction func onAddPostBtnClicked(_ sender: UIButton) {
    if let action = onAddPostAction {
      action()
      self.navigationController?.popViewController(animated: true)
    }
  }
}

//
//  ViewController.swift
//  Bunjang-CloneCoding
//
//  Created by 최용헌 on 11/2/24.
//

import UIKit
import Combine

import PanModal

class ViewController: UIViewController  {

  let viewModel = ViewModel.shared
  
  @IBOutlet weak var itemInfomationView: ItemInfomationView!
  
  @IBOutlet weak var itemInfomationViewHeightAnchor: NSLayoutConstraint!
  
  @IBOutlet weak var scrollView: UIScrollView!
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    setupDelegate()
    
    viewModel.showPopupVC
      .sink { showPopup in
        guard let isShowPopup = showPopup else { return }
        if isShowPopup {
          self.showCategroyChangePopup()
        }
      }
      .store(in: &ViewModel.shared.cancellabels)
    
    viewModel.changeCategoryButtonTapped
      .sink { changedCategory in
        guard let isChangedCategory = changedCategory else { return }
        if isChangedCategory {
          let bottomVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BottomSheetViewController") as! BottomSheetViewController
          self.presentPanModal(bottomVC)
        }
      }
      .store(in: &ViewModel.shared.cancellabels)
    
    viewModel.changeStatusButtonTapped
      .sink { changeStatus in
        guard let isChagneStatus = changeStatus else { return }
        if isChagneStatus {
          self.dismiss(animated: true)
        }
      }
      .store(in: &viewModel.cancellabels)
  }
  
  
  /// delegate 설정 함수
  func setupDelegate(){
    itemInfomationView.delegate = self
    scrollView.delegate = self
  }
  
  /// 카테고리 변경 popupView 띄우기
  func showCategroyChangePopup(){
    let popupVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PopupViewController") as! PopupViewController
    self.addChild(popupVC)
    popupVC.view.frame = self.view.frame
    self.view.addSubview(popupVC.view)
    popupVC.didMove(toParent: self)
  }
}

extension ViewController: UIScrollViewDelegate {
  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    view.endEditing(true)
  }
}

extension ViewController: ItemInfomationViewDelegate {
  func navToExceptionItemListVC(sender: UIButton) {
    self.performSegue(withIdentifier: "ExceptionItemListVC", sender: sender)
  }
  
  func navToSelectCategoryVC(sender: UIButton){
    self.performSegue(withIdentifier: "navToSeletCategoryVC", sender: sender)
  }
  
  func updateViewConstraint(height: CGFloat) {
    itemInfomationViewHeightAnchor.constant = height
  }
}

//
//  UIPageVCViewController.swift
//  week-10
//
//  Created by 최용헌 on 12/30/24.
//

import UIKit

class AlaramVC: UIViewController {
  enum PageType: Int {
    case newIssue = 0
    case bookmarkSearch = 1
  }
  
  @IBOutlet weak var mySegmentController: UISegmentedControl!
  
  @IBOutlet weak var underLineView: UIView!
  
  @IBOutlet weak var unerLineViewLeadingConstraint: NSLayoutConstraint!
  var embededMyOnboardingPageVC: MyOnboardingPageViewController? {
    return children.first(where: { $0 is MyOnboardingPageViewController }) as? MyOnboardingPageViewController
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    embededMyOnboardingPageVC?.currentPageChanged = { [weak self] currentPage in
      self?.mySegmentController.selectedSegmentIndex = currentPage
      self?.segmentAction(selectedIndex: currentPage)
    }
    
    setupSegmentController()
  }
  
  /// segment 설정
  func setupSegmentController(){
    
    // 글자 색상 변경
    
    mySegmentController.setTitleTextAttributes([
      NSAttributedString.Key.foregroundColor: UIColor.lightGray,
      NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)
    ], for: .normal)
    
    mySegmentController.setTitleTextAttributes([
      NSAttributedString.Key.foregroundColor: UIColor.black,
      NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)
    ], for: .selected)
    
    
    // 배경 색 변경
    let unselectedBackgroundImage = UIImage(color: UIColor.white)
    
    mySegmentController.setBackgroundImage(unselectedBackgroundImage, for: .normal, barMetrics: .default)
    mySegmentController.setBackgroundImage(unselectedBackgroundImage, for: .selected, barMetrics: .default)
    
    // 디바이더 제거
    mySegmentController.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
    
    // 액션 설정
    mySegmentController.addTarget(self, action: #selector(handleOnboarding(_:)), for: .valueChanged)
  }
  
  /// 세그먼트를 이용해 화면전환
  /// - Parameter sender: segment
  @objc fileprivate func handleOnboarding(_ sender: UISegmentedControl) {
      let pageIndex = sender.selectedSegmentIndex
      embededMyOnboardingPageVC?.changePage(pageIndex: pageIndex)
  }

  
  
  /// segment에 따른 underLine 움직임 변화
  /// - Parameter segment: segment
  @objc private func segmentAction(selectedIndex: Int) {
    // 세그먼트 갯수만큼
    let segmentWidth = mySegmentController.frame.width / CGFloat(mySegmentController.numberOfSegments)

    // 선택된 세그먼트가 0 / 1 일 때 leadingPostion
    let leadingPosition = segmentWidth * CGFloat(selectedIndex)

    UIView.animate(withDuration: 0.2) {
      self.unerLineViewLeadingConstraint.constant = leadingPosition
      self.view.layoutIfNeeded()
    }
  }
}

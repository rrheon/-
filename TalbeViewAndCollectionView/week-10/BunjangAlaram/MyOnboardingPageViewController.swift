//
//  MyOnboardingPageViewController.swift
//  week-10
//
//  Created by 최용헌 on 12/30/24.
//

import UIKit

class MyOnboardingPageViewController: UIPageViewController {
  
  var titleList: [String] = ["새소식", "즐겨찾는 검색"]
  
  var pageVCList: [AlaramComponentViewController] = []
  
  var currentPageIndex: Int? = nil
  
  var currentPageChanged : ((Int) -> Void)? = nil
  
  override func viewDidLoad() {
    print(#fileID, #function, #line," - ")
    
    // 타이틀을 가지고 vc 생성
    pageVCList = titleList.map({ AlaramComponentViewController.getInstace(title: $0) })
    
    setViewControllers([pageVCList[0]], direction: .forward, animated: true, completion: nil)
    
    delegate = self
    dataSource = self
  }
  
  // 새소식 - 0 -> 즐겨찾기
  // 즐겨찾기 - 1 -> 새소시
  func changePage(pageIndex: Int){
    print(#fileID, #function, #line, "- ")
    
    setViewControllers([pageVCList[pageIndex]], direction: .forward, animated: false, completion: { [weak self] value in
      guard let self = self else { return }
      self.currentPageIndex = pageIndex
      self.currentPageChanged?(pageIndex)
    })
  }
  
}

// MARK: - DataSource

extension MyOnboardingPageViewController: UIPageViewControllerDataSource {
  func pageViewController(_ pageViewController: UIPageViewController,
                          viewControllerBefore viewController: UIViewController) -> UIViewController? {
    
    let currentPageIndex = pageVCList.firstIndex(of: viewController as! AlaramComponentViewController ) ?? 0
    self.currentPageChanged?(currentPageIndex)
    
    if currentPageIndex == 0 { return pageVCList[pageVCList.count - 1] }
    
    return pageVCList[currentPageIndex - 1]
  }
  
  func pageViewController(_ pageViewController: UIPageViewController,
                          viewControllerAfter viewController: UIViewController) -> UIViewController? {
    
    let currentPageIndex = pageVCList.firstIndex(of: viewController as! AlaramComponentViewController ) ?? 0
    self.currentPageChanged?(currentPageIndex)
    
    
    if currentPageIndex == pageVCList.count - 1 { return pageVCList[0] }
    
    return pageVCList[currentPageIndex + 1]
  }
}

// MARK: - Delegate

extension MyOnboardingPageViewController : UIPageViewControllerDelegate{
  // 좌우 스와이프로 페이지이동 완료 시 인덱스 전달
  func pageViewController(_ pageViewController: UIPageViewController,
                          didFinishAnimating finished: Bool,
                          previousViewControllers: [UIViewController],
                          transitionCompleted completed: Bool) {
    if completed {
      let currentVC = viewControllers?.first
      if let index = pageVCList.firstIndex(of: currentVC as! AlaramComponentViewController) {
        currentPageIndex = index
        currentPageChanged?(index)
      }
    }
  }
}

//
//  SelectCategoryScene.swift
//  Bunjang-CloneCoding
//
//  Created by 최용헌 on 11/6/24.
//

import UIKit

import Combine

final class SelectCategoryViewController: UIViewController {
  let viewModel = ViewModel.shared
  
  @IBOutlet weak var recommendCategoryButton1: UIButton!
  @IBOutlet weak var recommendCategoryButton2: UIButton!
  @IBOutlet weak var recommendCategoryButton3: UIButton!
  @IBOutlet weak var recommendCategoryButton4: UIButton!
  private lazy var buttons: [UIButton] = [recommendCategoryButton1,recommendCategoryButton2,recommendCategoryButton3,recommendCategoryButton4]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.setHidesBackButton(true, animated: true)

    setCategoryData()
    
    // TODO: 카테고리 선택하면 viewcontroller에서 어떻게 적용할지
    buttons.forEach {
      $0.addTarget(self, action: #selector(onCategoryButtonClicked), for: .touchUpInside)
    }
  }
  
  @objc func onCategoryButtonClicked(sender: UIButton){
    // viewmodel에서 함수를 이용해서 버튼의 타이틀을 가져옴 -> 가져온게 변화가 확인되면 카테고리 버튼에 입력
    guard let title = sender.titleLabel?.text else { return }
    self.navigationController?.popViewController(animated: true)

    viewModel.getButtonTitle(title: title)
  }
  
  /// 추천 카테고리의 title 설정
  func setCategoryData(){
    let categoryNames: [String] = ["식품 > 간식","스타굿즈 > 보이그룹 > 인형/피규어","뷰티/미용 > 다이어트/이너뷰티","식품 > 건강식품"]
    let changedCategoryNames = attributedCategoryNames(with: categoryNames, color: .lightGray)
  
    
    for (index, title) in changedCategoryNames.enumerated() {
      buttons[index].setAttributedTitle(title, for: .normal)
    }
  }
  
  /// 상품등록화면으로 이동
  /// - Parameter sender: 뒤로가기 버튼
  @IBAction func navToRootVC(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
  }
  
  /// 특정 문자 색상 변경 - > 색상변경
  /// - Parameters:
  ///   - categories: 변경할 문자열
  ///   - color: 변경할 색상
  /// - Returns: 변환된 문자열
  func attributedCategoryNames(with categories: [String], color: UIColor) -> [NSAttributedString] {
    return categories.map { category in
      let attributedString = NSMutableAttributedString(string: category)
      let separator = ">"
      
      var searchRange = category.startIndex..<category.endIndex
      while let range = category.range(of: separator, options: [], range: searchRange) {
        let nsRange = NSRange(range, in: category)
        attributedString.addAttribute(.foregroundColor, value: color, range: nsRange)
        
        searchRange = range.upperBound..<category.endIndex
      }
      
      return attributedString
    }
  }
}

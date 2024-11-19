//
//  AgreementComponent.swift
//  NaverLogin
//
//  Created by 최용헌 on 11/14/24.
//

import UIKit

// 보내는 쪽 -> 동의버튼 . 받는쪽 밑에 버튼
protocol SelectAcceptEventDelegate: AnyObject {
  func selectAcceptEventButton(selected: Bool)
}

final class AgreementComponent: UIView {
  weak var delegate: SelectAcceptEventDelegate?
  
  @IBOutlet weak var showAllContentButton: UIButton!
  
  var isShowAllContentButton: Bool = false
  
  var isForKid: Bool = true {
    didSet {
      DispatchQueue.main.async {
        self.agreementButton.isHidden = self.isForKid
      }
    }
  }
  
  var buttonTitle: String = "" {
    didSet {
      updateButtonTitleUI()
    }
  }
  
  var content: String = "" {
    didSet {
      DispatchQueue.main.async {
        self.contentLabel.text = self.content
      }
    }
  }
  
  @IBOutlet weak var agreementStackViewTrailingAnchor: NSLayoutConstraint!
  @IBOutlet weak var agreementStackView: UIStackView!
  
  // 동의하기 체크 아이콘 버튼
  @IBOutlet weak var agreementButton: UIButton!
  // 동의하기 문구 버튼
  @IBOutlet weak var agreementButton2: UIButton!
  @IBOutlet weak var agreemenTitleLabel: UILabel!
  
  @IBOutlet weak var moreContentButton: UIButton!
  
  @IBOutlet weak var agreementForKidButton: UIView!
  @IBOutlet weak var contentLabel: UILabel!
  
  @IBOutlet weak var contentScrollView: UIScrollView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    applyNib()
    updateButtonTitleUI()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    applyNib()
  }
  
  /// 동의항목 UI 초기화
  /// - Parameters:
  ///   - title: 동의항목의 제목
  ///   - content: 동의항목의 내용
  ///   - isHideForKidButton: 어린이용 버튼 숨김 여부
  convenience init(
    title: String = "",
    content: String = "",
    isHideForKidButton: Bool = true,
    showAllContentButton: Bool = false
  ) {
    self.init(frame: .zero)
    
    self.buttonTitle = title
    self.content = content
    self.isForKid = isHideForKidButton
    self.isShowAllContentButton = showAllContentButton
  }
  
  /// buttonTitle에 따라 UI 업데이트 - 필수 / 선택에 따라 색상 변경
  private func updateButtonTitleUI() {
    DispatchQueue.main.async {
      let changeText: String = self.buttonTitle.contains("[필수]") ? "[필수]" : "[선택]"
      let color: UIColor = self.buttonTitle.contains("[필수]") ? .activateButtonColor : .lightGray
      
      self.agreementButton.tintColor = .gray
      self.agreemenTitleLabel.text = self.buttonTitle
      self.agreemenTitleLabel.changeColor(wantToChange: changeText, color: color)
      self.agreementForKidButton.isHidden = self.isForKid
      self.contentLabel.text = self.content
      self.showAllContentButton.isHidden = self.isShowAllContentButton
      
      // 어린이용 버튼이 있다면
      if self.isForKid {
        self.agreementStackViewTrailingAnchor.constant = 10
      }
    }
  }
  
  
  /// 동의항목 터치 시 UI 변경
  /// - Parameter sender: 해당 동의항목 버튼
  @IBAction func agreementButtonTapped(_ sender: UIButton){
    agreementButton.isSelected.toggle()

    let imageName: String = agreementButton.isSelected ? "checkmark.circle.fill" : "checkmark.circle"
    
    self.agreementButton.setImage(UIImage(systemName: imageName), for: .normal)
    self.agreementButton.tintColor = agreementButton.isSelected ? .activateButtonColor : .gray
    
    if content.isEmpty {
      delegate?.selectAcceptEventButton(selected: agreementButton.isSelected)
    }
  }
  
  /// 모두 동의 버튼 터치 시
  /// - Parameter allBtnSelected: 모두 동의 버튼 선택 여부
  func allAgreementButtonTapped(allBtnSelected: Bool){
    switch allBtnSelected {
    case true:
      setupButtonUI(imageName: "checkmark.circle.fill", color: .activateButtonColor, selected: true)
    case false:
      setupButtonUI(imageName: "checkmark.circle", color: .gray, selected: false)
    }
    
    if content.isEmpty {
      delegate?.selectAcceptEventButton(selected: allBtnSelected)
    }
  }
  
  
  /// 버튼 선택 시 UI 변경
  /// - Parameters:
  ///   - imageName: 변경할 이미지 이름
  ///   - color: 변경할 색상
  ///   - selected: 선택여부
  func setupButtonUI(imageName: String, color: UIColor, selected: Bool){
    self.agreementButton.setImage(UIImage(systemName: imageName), for: .normal)
    self.agreementButton.tintColor = color
    agreementButton.isSelected = selected
  }
  
}

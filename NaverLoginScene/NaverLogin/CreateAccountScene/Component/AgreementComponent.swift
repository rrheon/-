//
//  AgreementComponent.swift
//  NaverLogin
//
//  Created by 최용헌 on 11/14/24.
//

import UIKit


/// 필수/선택 항목 색상에 대한 enum
enum AgreementCase {
  case essential
  case choice
  
  func returnColor() -> UIColor {
    switch self {
    case .essential:
      return .activateButtonColor
    case .choice:
      return .lightGray
    }
  }
}


final class AgreementComponent: UIView {
  
  var isButtonTapped: Bool = false
  
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
    print(#fileID, #function, #line," - comment")
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
  convenience init(title: String = "", content: String = "", isHideForKidButton: Bool = true) {
    self.init(frame: .zero)
    
    self.buttonTitle = title
    self.content = content
    self.isForKid = isHideForKidButton
  }
  
  /// buttonTitle에 따라 UI 업데이트 - 필수 / 선택에 따라 색상 변경
  private func updateButtonTitleUI() {
    DispatchQueue.main.async {
      let changeText: String = self.buttonTitle.contains("[필수]") ? "[필수]" : "[선택]"
      let type: AgreementCase = self.buttonTitle.contains("[필수]") ? .essential : .choice
      let color: UIColor = type.returnColor()
      
      
      self.agreementButton.tintColor = .gray
      self.agreemenTitleLabel.text = self.buttonTitle
      self.agreemenTitleLabel.changeColor(wantToChange: changeText, color: color)
      self.agreementForKidButton.isHidden = self.isForKid
      self.contentLabel.text = self.content
      
      if self.isForKid {
        self.agreementStackViewTrailingAnchor.constant = 10
      }
    }
  }
  
  
  /// 동의항목 터치 시 UI 변경
  /// - Parameter sender: 해당 동의항목 버튼
  @IBAction func agreementButtonTapped(_ sender: UIButton){
    let imageName: String = !isButtonTapped ? "checkmark.circle.fill" : "checkmark.circle"
    
    self.agreementButton.setImage(UIImage(systemName: imageName), for: .normal)
    self.agreementButton.tintColor = !isButtonTapped ? .activateButtonColor : .gray
  }
  
  
  /// 모두 동의 버튼 터치 시
  /// - Parameter allBtnSelected: 모두 동의 버튼 선택 여부
  func allAgreementButtonTapped(allBtnSelected: Bool){
    // 모두 동의 버튼 선택 , 개별 버튼 선택 안했을 경우
    if allBtnSelected && !isButtonTapped {
      self.agreementButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
      self.agreementButton.tintColor = .activateButtonColor
      // 모두 동의 버튼 선택 , 개별 버튼 선택 했을 경우
    } else if allBtnSelected && isButtonTapped{
      isButtonTapped.toggle()
      return
      // 모두 동의 버튼 선택 x , 개별 버튼 선택 했을 경우
    }else if !allBtnSelected && isButtonTapped {
      self.agreementButton.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
      self.agreementButton.tintColor = .gray
    }
    
    isButtonTapped.toggle()
    
  }
}

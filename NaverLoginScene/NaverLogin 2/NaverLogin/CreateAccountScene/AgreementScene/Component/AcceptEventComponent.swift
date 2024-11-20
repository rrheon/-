//
//  AcceptEventCompoent.swift
//  NaverLogin
//
//  Created by 최용헌 on 11/14/24.
//

import UIKit

final class AcceptEventComponent: UIView {
  @IBOutlet weak var acceptEventButton: UIButton!
  @IBOutlet weak var alertLabel: UILabel!
  @IBOutlet weak var createGroupAccountButtonTopAnchor: NSLayoutConstraint!
  
  var isAlertLabelHidden: Bool = true
  
  override func awakeFromNib() {
    super.awakeFromNib()
    print(#fileID, #function, #line," - awake")

    alertLabel.isHidden = true
    createGroupAccountButtonTopAnchor.constant = 50
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    print(#fileID, #function, #line," - init")

    applyNib()
    
    alertLabel.isHidden = true
    createGroupAccountButtonTopAnchor.constant = 50
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    applyNib()
  }
  
  
  /// accept 버튼 터치 시 UI 변경
  /// - Parameter sender: 이벤트·혜택 정보 수신 버튼
  @IBAction func onAcceptEventButtonClicked(_ sender: UIButton) {
    sender.isSelected.toggle()
    
    print(#fileID, #function, #line," - \(acceptEventButton.isSelected)")
    isAlertLabelHidden.toggle()
    setupButtonUI(isTapped: sender.isSelected, alertLabelHidden: isAlertLabelHidden)
  }
  
  
  /// 이벤트혜택 정보 수신 버튼 UI 세팅
  /// - Parameter isTapped: 버튼 터치 여부
  func setupButtonUI(isTapped: Bool, alertLabelHidden: Bool = true){
    alertLabel.isHidden = alertLabelHidden
    createGroupAccountButtonTopAnchor.constant = alertLabelHidden ? 50 : 80
    
    acceptEventButton.tintColor = isTapped ? .activateButtonColor : .lightGray
  }
}


extension AcceptEventComponent: SelectAcceptEventDelegate{
  
  /// 이벤트 혜택 정보수신 버튼 터치 설정
  /// - Parameter selected: 개인정보 수집 및 이용 버튼 혹은 전체동의버튼 선택 여부
  func selectAcceptEventButton(selected: Bool) {
    acceptEventButton.isSelected = selected
    setupButtonUI(isTapped: selected)
  }
}

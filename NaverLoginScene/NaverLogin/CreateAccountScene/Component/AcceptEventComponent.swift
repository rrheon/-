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
  
  var isAcceptEventButtonTapped: Bool = false
  
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
    isAcceptEventButtonTapped.toggle()
    
    print(#fileID, #function, #line," - \(acceptEventButton.isSelected)")

    alertLabel.isHidden = isAcceptEventButtonTapped
    createGroupAccountButtonTopAnchor.constant = isAcceptEventButtonTapped ? 50 : 80
    
    acceptEventButton.tintColor = isAcceptEventButtonTapped ? .activateButtonColor : .lightGray
    acceptEventButton.setTitleColor(.lightGray, for: .normal)
  }
}

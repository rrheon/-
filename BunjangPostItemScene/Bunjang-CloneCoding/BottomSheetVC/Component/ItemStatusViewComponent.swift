//
//  ItemStatusViewComponent.swift
//  Bunjang-CloneCoding
//
//  Created by 최용헌 on 11/7/24.
//

import UIKit

import PanModal

final class ItemStatusViewComponent: CustomView {
  
  let viewModel = ViewModel.shared
  
  @IBOutlet weak var statusNewButton: UIButton!
  @IBOutlet weak var statusNoUseButton: UIButton!
  @IBOutlet weak var statusLessUseButton: UIButton!
  @IBOutlet weak var statusManyUseButton: UIButton!
  @IBOutlet weak var statusFailureButton: UIButton!
  
  @IBOutlet weak var changeItemStatusButton: UIButton!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    applyNib()
  
    [
      statusNewButton,
      statusNoUseButton,
      statusLessUseButton,
      statusManyUseButton,
      statusFailureButton
    ].forEach {
      $0?.addTarget(self, action: #selector(statusButtonTapped), for: .touchUpInside)
    }
    
    changeItemStatusButton.addAction(UIAction { _ in
      self.viewModel.changeItemStatus()
    }, for: .touchUpInside)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  @objc func statusButtonTapped(sender: UIButton){
    let allButtons = [
      statusNewButton, statusNoUseButton, statusLessUseButton, statusManyUseButton, statusFailureButton
    ]
    allButtons.forEach {
      // 버튼을 선택하면 선택되지 않은 버튼은 회색 선택된 버튼은 red
      // 이미 선택한 버튼을 다시 선택하면 회색으로
      if $0 == sender && sender.borderColor == UIColor.lightGray {
        $0?.borderColor = .red
      } else {
        $0?.borderColor = .lightGray
      }
    }
  
    var itemStatus: String
    
    switch sender {
    case statusNewButton:
      itemStatus = "새 상품(미사용)"
    case statusNoUseButton:
      itemStatus = "사용감 없음"
    case statusLessUseButton:
      itemStatus = "사용감 적음"
    case statusManyUseButton:
      itemStatus = "사용감 많음"
    case statusFailureButton:
      itemStatus = "고장/파손 상품"
    default:
      return
    }
    
    viewModel.itemStatus.send(itemStatus)
  }
}


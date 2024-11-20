//
//  keyboardToolbar.swift
//  NaverLogin
//
//  Created by 최용헌 on 11/12/24.
//

import UIKit

protocol KeyboardToolbarDelegate: AnyObject {
  func onCloseButtonClicked()
}

final class KeyboardToolbar: UIToolbar {
  weak var toolbarDelegate: KeyboardToolbarDelegate?
  
  weak var textFieldLine: UIView? = nil
  
  private lazy var closeButton: UIButton = {
    let button = UIButton()
    button.setTitle("닫기", for: .normal)
    button.setTitleColor(.gray, for: .normal)
    button.addTarget(self, action: #selector(onCloseButtonClicked), for: .touchUpInside)
    return button
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  /// toolbar의 버튼 추가
  /// - Parameters:
  ///   - leftBarButtons: 왼쪽 버튼들 추가
  ///   - rightBarButton: 오른쪽 버튼 추가
  convenience init(leftBarButtons: [UIButton]? = nil, rightBarButton: UIButton? = nil) {
    self.init(frame: .zero)
    
    var barButtons = [UIBarButtonItem]()
    
    if let leftButtons = leftBarButtons {
      for (index, button) in leftButtons.enumerated() {
        barButtons.append(UIBarButtonItem(customView: button))
        
        // 첫번째 버튼 이후에 고정된 공간 추가
        if index == 0 {
          let space = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
          space.width = 20
          barButtons.append(space)
        }
      }
    }
    
    // 왼쪽과 오른쪽 버튼 사이에 공간 추가
    barButtons.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
    
    // 오른쪽 버튼 추가
    let rightButton = rightBarButton ?? closeButton
    barButtons.append(UIBarButtonItem(customView: rightButton))
    
    self.items = barButtons
    self.sizeToFit()
  }

  @objc func onCloseButtonClicked(){
    toolbarDelegate?.onCloseButtonClicked()
    
    if let line = textFieldLine {
      line.borderWidth = 1
    }
  }
}


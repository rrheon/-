//
//  ItemPriceView.swift
//  Bunjang-CloneCoding
//
//  Created by 최용헌 on 11/4/24.
//

import UIKit

final class ItemPriceView: CustomView {
  
  @IBOutlet weak var priceSymbolLabel: UILabel!
  @IBOutlet weak var priceTextField: UITextField!
  
  @IBOutlet weak var priceTextFieldUnderLineView: UIView!
  
  @IBOutlet weak var prePriceStackView: UIStackView!
  
  @IBOutlet weak var addtionalSettingTopAnchor: NSLayoutConstraint!
  
  
  /* TODO: 
   가격심볼 - textField 터치 시 검은색 ,비어있으면 라이트그레이
   underline 검정 - textField 터치 시 검은색, 입력 끝나면 라이트그레이
   텍스트필드 입력 시 자동으로 콤마, 색상 검정

   예상 정산금액 - 택스트필드가 비어있으면 사라지고 입력되면 (1이상 입력 시) 나옴, 최대 999,999,999
   
   
   */
  override func awakeFromNib() {
    super.awakeFromNib()
    priceTextField.keyboardType = .numberPad
    priceTextField.resignFirstResponder()
    priceTextField.becomeFirstResponder()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}

//
//  ItemInfomationView.swift
//  Bunjang-CloneCoding
//
//  Created by 최용헌 on 11/2/24.
//

import UIKit

final class ItemInfomationView: CustomView, UITextViewDelegate {
  
  @IBOutlet weak var itemImageOrVideoStackView: UIStackView!
  @IBOutlet weak var addItemImageOrVideoButton: UIButton!
  @IBOutlet weak var itemNameTextField: UITextField!
  @IBOutlet weak var categoryButton: UIButton!
  @IBOutlet weak var categoryLabel: UILabel!
  @IBOutlet weak var itemDescriptionTextView: UITextView!
  @IBOutlet weak var textViewCountLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    print(#fileID, #function, #line, " - ")
    applyNib()
    
    addItemImageOrVideoButton.addTarget(self, action: #selector(onAddItemImageOrVideoButtonClicked), for: .touchUpInside)
    categoryButton.addTarget(self, action: #selector(onCategoryButtonClicked), for: .touchUpInside)
    
    setupUnderLinedView(itemNameTextField)
    setupUnderLinedView(categoryLabel)
    
    itemDescriptionTextView.delegate = self
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    print(#fileID, #function, #line, " - ")
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    print(#fileID, #function, #line, " - ")
  }
  
  @objc func onAddItemImageOrVideoButtonClicked(sender: UIButton) {
    print(#fileID, #function, #line, " - ")
    
    let test: ItemImageView = ItemImageView(imageName: "pencil")
    test.translatesAutoresizingMaskIntoConstraints = false
    itemImageOrVideoStackView.addArrangedSubview(test)
    NSLayoutConstraint.activate([
      test.widthAnchor.constraint(equalToConstant: 100)
    ])
    
    layoutIfNeeded()
  }
  
  @objc func onCategoryButtonClicked(sender: UIButton) {
    print(#fileID, #function, #line, " - ")
  }
  
  
  /// textView 글자 수 세기
  /// - Parameters:
  ///   - textView: 해당 textView
  ///   - range: <#range description#>
  ///   - text: <#text description#>
  /// - Returns: <#description#>
  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    let currentText = textView.text ?? ""
    guard let stringRange = Range(range, in: currentText) else { return false }
    
    let changedText = currentText.replacingCharacters(in: stringRange, with: text)
    
    textViewCountLabel.text = "\(changedText.count)/2000"
    return changedText.count <= 2000
  }
}

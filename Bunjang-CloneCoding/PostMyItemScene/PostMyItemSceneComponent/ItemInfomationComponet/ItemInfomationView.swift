//
//  ItemInfomationView.swift
//  Bunjang-CloneCoding
//
//  Created by 최용헌 on 11/2/24.
//

import UIKit

protocol ItemInfomationViewDelegate {
  func updateViewConstraint(height: CGFloat)
  func navToExceptionItemListVC(sender: UIButton)
  func navToSelectCategoryVC(sender: UIButton)
}

final class ItemInfomationView: CustomView {
  var delegate: ItemInfomationViewDelegate?
  
  let viewModel = ViewModel.shared
  
  @IBOutlet weak var itemImageOrVideoStackView: UIStackView!
  @IBOutlet weak var addItemImageOrVideoButton: UIButton!
  
  @IBOutlet weak var itemNameTextField: UITextField!
  @IBOutlet weak var itemNameLabelUnderLineView: UIView!
  
  @IBOutlet weak var autoSelectCategoryView: ItemCategoryView!
  @IBOutlet weak var selectCategoryTopAnchor: NSLayoutConstraint!
  @IBOutlet weak var categoryLabel: UILabel!
  
  @IBOutlet weak var itemDescriptionTextView: UITextView!
  @IBOutlet weak var textViewCountLabel: UILabel!
  
  private lazy var toolbarLeftButton: UIButton = {
    let button = UIButton()
    button.setTitle("거래금지품목", for: .normal)
    button.setTitleColor(.gray, for: .normal)
    button.setImage(UIImage(systemName: "exclamationmark.circle"), for: .normal)
    button.tintColor = .gray
    button.addAction(UIAction { _ in
      self.delegate?.navToExceptionItemListVC(sender: button)
    }, for: .touchUpInside)
    return button
  }()
  
  private lazy var toolbarRightButton: UIButton = {
    let button = UIButton()
    button.setTitle("닫기", for: .normal)
    button.setTitleColor(.gray, for: .normal)
    button.addAction(UIAction { _ in
      self.endEditing(true)
    }, for: .touchUpInside)
    return button
  }()
  
  @IBOutlet weak var itemStautsView: UIView!
  @IBOutlet weak var itemSizeView: UIView!
  
  // 상품상태, 사이즈가 있을 때 100 없을 때 20?
  @IBOutlet weak var describLabelTopAnchor: NSLayoutConstraint!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    // 사진추가버튼 너비 설정
    NSLayoutConstraint.activate([
      addItemImageOrVideoButton.widthAnchor.constraint(equalToConstant: 75)
    ])
    
    addButtonActions()
    
    autoSelectCategoryView.isHidden = true
    selectCategoryTopAnchor.constant = 20
    
    setupCategoryUI(hidden: true, topAnchor: 20, viewHeight: 500)
    
    itemNameTextField.autocorrectionType = .no
    itemNameTextField.spellCheckingType = .no
    itemNameTextField.inputAccessoryView = KeyboardToolbar(leftBarButton: toolbarLeftButton,
                                                           rightBarButton: toolbarRightButton)
    
    itemNameTextField.delegate = self
    itemDescriptionTextView.delegate = self
    
    viewModel.selectedCategory
      .sink { categoryTitle in
        self.categoryLabel.text = categoryTitle
        
        if categoryTitle != "카테고리" {
          self.categoryLabel.textColor = .black
          self.setupCategoryUI(hidden: false, topAnchor: 100, viewHeight: 580)
          // categoryTitle 가 카테고리가 아닌 경우는 이미 카테고리가 있는 경우 -> 팝업을 띄어야함 ->
        }
      }
      .store(in: &viewModel.cancellabels)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  
  func setupCategoryUI(hidden: Bool, topAnchor: CGFloat, viewHeight: CGFloat){
    itemStautsView.isHidden = hidden
    itemSizeView.isHidden = hidden
    describLabelTopAnchor.constant = topAnchor
    delegate?.updateViewConstraint(height: viewHeight)
  }
  
  // 버튼에 함수 설정
  func addButtonActions(){
    addItemImageOrVideoButton.addTarget(self, action: #selector(onAddItemImageOrVideoButtonClicked), for: .touchUpInside)
 
    [
      autoSelectCategoryView.itemCategory1Button,
      autoSelectCategoryView.itemCategory2Button,
      autoSelectCategoryView.itemCategory3Button,
      autoSelectCategoryView.itemCategory4Button
    ].forEach {
      $0?.addTarget(self, action: #selector(onAutoSelectedCategoryButtonClicked), for: .touchUpInside)
    }
  }
  
  /// 상품 사진 추가
  /// - Parameter sender: 사진/동영상  버튼
  @objc func onAddItemImageOrVideoButtonClicked(sender: UIButton) {
    print(#fileID, #function, #line, " - ")
    
    let test: ItemImageView = ItemImageView(imageName: "pencil")
    itemImageOrVideoStackView.addArrangedSubview(test)
    NSLayoutConstraint.activate([
      test.widthAnchor.constraint(equalToConstant: 75)
    ])
    
    layoutIfNeeded()
  }
  
  
  ///  추천 카테고리 선택
  /// - Parameter sender: 추천 카테고리 버튼
  @objc func onAutoSelectedCategoryButtonClicked(sender: UIButton){
    guard let view = autoSelectCategoryView else { return }
    switch sender {
    case view.itemCategory1Button:
      viewModel.getButtonTitle(title: view.itemCategory1Label.text ?? "카테고리")
    case view.itemCategory2Button:
      viewModel.getButtonTitle(title: view.itemCategory2Label.text ?? "카테고리")
    case view.itemCategory3Button:
      viewModel.getButtonTitle(title: view.itemCategory3Label.text ?? "카테고리")
    case view.itemCategory4Button:
      viewModel.getButtonTitle(title: view.itemCategory4Label.text ?? "카테고리")
    default:
      return
    }
    
    categoryLabel.textColor = .black

    selectCategoryTopAnchor.constant = 20
    autoSelectCategoryView.isHidden = true
    
    delegate?.updateViewConstraint(height: 600)
  }
  
  /// 카테고리 설정
  /// - Parameter sender: 카테고리 버튼
  @IBAction func onCategoryButtonClicked(_ sender: Any) {
    print(#fileID, #function, #line," - 버튼댑")

    delegate?.navToSelectCategoryVC(sender: sender as! UIButton)
    /**
     카테고리가 있는 경우 - 카테고리를 변경할까요? 라는 팝업뜸
     없는경우 - 그냥 변경
     
     카테고리 변경 후 bottomsheet올라옴
     */
  }
}

extension ItemInfomationView: UITextViewDelegate, UITextFieldDelegate {
  
  /// textView 글자 수 세기
  /// - Parameters:
  ///   - textView: 해당 textView
  ///   - range:사용자가 입력한 text의 범위
  ///   - text: 사용자가 입력한 text
  /// - Returns: 제한할 글자수 범위
  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    let currentText = textView.text ?? ""
    guard let stringRange = Range(range, in: currentText) else { return false }
    
    let changedText = currentText.replacingCharacters(in: stringRange, with: text)
    
    textViewCountLabel.text = "\(changedText.count)/2000"
    return changedText.count <= 2000
  }
  
  /// textField 입력 시 underLine 색 변경
  /// - Parameter textField: textFiedl
  func textFieldDidBeginEditing(_ textField: UITextField) {
    print(#fileID, #function, #line," - texfield")

      itemNameLabelUnderLineView.backgroundColor = UIColor.black
    
  }
  
  /// textField입력 시 category 보이게 설정
  /// - Parameter textField: 상품명 textFiedl
  func textFieldDidChangeSelection(_ textField: UITextField) {
    // textField가 비어있는경우
    guard let contentIsEmpty = textField.text?.isEmpty, !contentIsEmpty else {
      selectCategoryTopAnchor.constant = 20
      autoSelectCategoryView.isHidden = true
      delegate?.updateViewConstraint(height: 500)
      return
    }
    
    // 텍스트가 비어 있지 않고 특정 값이 아닌 경우 높이와 위치 조정
    if let text = itemNameTextField.text, !text.isEmpty, text != "상품명" {
      selectCategoryTopAnchor.constant = 65
      autoSelectCategoryView.isHidden = false
      
      let height: CGFloat = categoryLabel.text != "카테고리" ? 600 : 530
      delegate?.updateViewConstraint(height: height)
    }
  }

  ///  textField 입력 종료 시 underLine 색 변경
  /// - Parameters:
  ///   - textField: 상품명 textFeld
  ///   - reason:  입력 종료 이유
  func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
      itemNameLabelUnderLineView.backgroundColor = UIColor.lightGray
    
  }
}

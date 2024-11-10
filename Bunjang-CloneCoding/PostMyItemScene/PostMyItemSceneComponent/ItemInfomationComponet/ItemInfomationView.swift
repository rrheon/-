//
//  ItemInfomationView.swift
//  Bunjang-CloneCoding
//
//  Created by 최용헌 on 11/2/24.
//

import UIKit

import UITextView_Placeholder

protocol ItemInfomationViewDelegate {
  func updateViewConstraint(height: CGFloat)
  func navToExceptionItemListVC(sender: UIButton)
  func navToSelectCategoryVC(sender: UIButton)
}

final class ItemInfomationView: CustomView {
  var delegate: ItemInfomationViewDelegate?
  
  let viewModel = ViewModel.shared
  let textViewPlaceHolder = "브랜드, 모델명, 구매 시기, 하자 유무 등 상품 설명을 최대한 자세히 적어주세요.\n전화번호, SNS 계정 등 개인정보 입력은 제한될 수 있어요"
  
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
  @IBOutlet weak var itemStatusButton: UIButton!
  
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
    itemDescriptionTextView.placeholder = textViewPlaceHolder
    itemDescriptionTextView.sizeToFit()

    setupActions()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  
  /// viewmodel에서의 action
  func setupActions(){
    viewModel.selectedCategory
      .sink { title in
        guard let categoryTitle = title else { return }
        if self.categoryLabel.text != "카테고리" && self.categoryLabel.text != categoryTitle {
          // categoryTitle 가 카테고리가 아닌 경우는 이미 카테고리가 있는 경우 -> 팝업을 띄어야함 ->
          self.viewModel.showPopupVC.send(true)
        } else {
          // 그냥 기본 카테고리일 경우 색상이 블랙으로 설정됨, 팝업뷰 뒤 배경이 흰색임 -> 투명으로 변경
          self.categoryLabel.text = categoryTitle
          self.viewModel.changeCategoryButtonTapped.send(true)
        }
        
        self.setupCategoryUI(hidden: false, topAnchor: 100, viewHeight: 580)
        
        let textColor: UIColor = self.categoryLabel.text == "카테고리" ? UIColor.lightGray : UIColor.black
        self.categoryLabel.textColor = textColor
      }
      .store(in: &viewModel.cancellabels)
    
    viewModel.changeCategoryButtonTapped
      .sink { tapped in
        guard let isTapped = tapped else { return }
        if isTapped {
          self.categoryLabel.text = self.viewModel.selectedCategory.value
        }
      }
      .store(in: &viewModel.cancellabels)
    
    viewModel.changeStatusButtonTapped
      .sink { changeStatus in
        guard let isChangedStatus = changeStatus else { return }
        if isChangedStatus {
          let itemStatus = self.viewModel.itemStatus.value
          self.itemStatusButton.setTitle(itemStatus, for: .normal)
          self.itemStatusButton.setTitleColor(.black, for: .normal)
        }
      }
      .store(in: &viewModel.cancellabels)
  }
  
  
  /// 카테고리가 선택되었을 때 UI 설정
  /// - Parameters:
  ///   - hidden: 상품상태 및 사이즈 UI hidden 여부
  ///   - topAnchor: 설명 textView의 topAnchor
  ///   - viewHeight: itemInfomationView의 높이
  func setupCategoryUI(hidden: Bool, topAnchor: CGFloat, viewHeight: CGFloat){
    itemStautsView.isHidden = hidden
    itemSizeView.isHidden = hidden
    describLabelTopAnchor.constant = topAnchor
    delegate?.updateViewConstraint(height: viewHeight)
  }
  
  // 버튼에 함수 설정
  func addButtonActions(){
    addItemImageOrVideoButton.addTarget(self, action: #selector(onAddItemImageOrVideoButtonClicked), for: .touchUpInside)
    
    itemStatusButton.addAction(UIAction { _ in
      self.viewModel.changeCategoryButtonTapped.send(true)
    }, for: .touchUpInside)
    
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
    var currentText = textView.text ?? ""
    if currentText == textViewPlaceHolder { currentText = "" }
    guard let stringRange = Range(range, in: currentText) else { return false }
    
    let changedText = currentText.replacingCharacters(in: stringRange, with: text)
    
    textViewCountLabel.text = "\(changedText.count)/2000"
    
    // TODO: 붙여넣기 하면 2000자 넘음 
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
  
  func textViewDidBeginEditing(_ textView: UITextView) {
    textView.textColor = .black
  }
  
  // MARK: textview 높이 자동조절
  func textViewDidChange(_ textView: UITextView) {
    let size = CGSize(width: self.frame.width, height: .infinity)
    let estimatedSize = textView.sizeThatFits(size)
    
    textView.constraints.forEach { (constraint) in
      
      /// 180 이하일때는 더 이상 줄어들지 않게하기
      if estimatedSize.height <= 180 {
        
      }
      else {
        if constraint.firstAttribute == .height {
          constraint.constant = estimatedSize.height
          
          // TODO:  상품상태,사이즈 / textfield입력 시 카테고리 나올 때 업데이트 되는 높이가 달라야함
          delegate?.updateViewConstraint(height: 450 + constraint.constant)
        }
      }
    }
  }
}

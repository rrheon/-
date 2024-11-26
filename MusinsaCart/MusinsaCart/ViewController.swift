//
//  ViewController.swift
//  MusinsaCart
//
//  Created by 최용헌 on 11/25/24.
//

import UIKit


/// 카테고리 데이터
struct CategoryDatas {
  var categoryName: String
  var btnSelected: Bool = false
}

class ViewController: UIViewController {
  
  @IBOutlet weak var categoryStackView: UIStackView!
    
  /// 카테고리 버튼 데이터
  var categoryDatas: [CategoryDatas] = [
    CategoryDatas(categoryName: "추천", btnSelected: true),
    CategoryDatas(categoryName: "랭킹"),
    CategoryDatas(categoryName: "세일"),
    CategoryDatas(categoryName: "브랜드"),
    CategoryDatas(categoryName: "신상"),
    CategoryDatas(categoryName: "무진장 3주년"),
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()

    self.navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = .black
    
    self.view.backgroundColor = .white
    
    // 네비게이션 아이템 설정
    setupLeftBarButton()
    setupRightBarButtons()
    
    // 카테고리 버튼 설정
    setupCategoryButtons()
  }
  
  
  /// 네비게이션 왼쪽 버튼
  func setupLeftBarButton(){
    let downArrowBtn = UIButton()
    downArrowBtn.setImage(UIImage(systemName: "chevron.down"), for: .normal)
    downArrowBtn.tintColor = .white
    downArrowBtn.layer.borderWidth = 1
    downArrowBtn.layer.borderColor = UIColor.lightGray.cgColor
    downArrowBtn.layer.cornerRadius = 2
    downArrowBtn.imageView?.contentMode = .scaleAspectFit
    downArrowBtn.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    
    let barButton = UIBarButtonItem(customView: downArrowBtn)
    
    navigationItem.leftBarButtonItems?.append(barButton)
  }
  
  /// 네비게이션 오른쪽 버튼
  func setupRightBarButtons(){
    // 카트버튼 설정
    let cartBtnView = UIView()
    
    let cartBtn = UIButton()
    cartBtn.setImage(UIImage(systemName: "bag"), for: .normal)
    cartBtn.tintColor = .white
    cartBtn.addTarget(self, action: #selector(onCartBtnClicked), for: .touchUpInside)
    cartBtn.translatesAutoresizingMaskIntoConstraints = false
    cartBtnView.addSubview(cartBtn)
    
    let cartCountImage = UIImageView(image: UIImage(systemName: "1.circle.fill"))
    cartCountImage.tintColor = .systemBlue
    cartCountImage.translatesAutoresizingMaskIntoConstraints = false
    cartBtnView.addSubview(cartCountImage)
    
    NSLayoutConstraint.activate([
      cartBtn.widthAnchor.constraint(equalToConstant: 30),
      cartBtn.heightAnchor.constraint(equalToConstant: 30),
      cartBtn.leadingAnchor.constraint(equalTo: cartBtnView.leadingAnchor),
      cartBtn.topAnchor.constraint(equalTo: cartBtnView.topAnchor),
      
      cartCountImage.widthAnchor.constraint(equalToConstant: 15),
      cartCountImage.heightAnchor.constraint(equalToConstant: 15),
      cartCountImage.trailingAnchor.constraint(equalTo: cartBtn.trailingAnchor, constant: -1),
      cartCountImage.topAnchor.constraint(equalTo: cartBtn.topAnchor, constant: 0)
    ])
    
    cartBtnView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      cartBtnView.widthAnchor.constraint(equalToConstant: 30),
      cartBtnView.heightAnchor.constraint(equalToConstant: 30)
    ])
    
    let cartBarButton = UIBarButtonItem(customView: cartBtnView)
    
    // 알람 버튼 설정
    let bellBtnView = UIView()
    
    let bellBtn = UIButton()
    bellBtn.setImage(UIImage(systemName: "bell"), for: .normal)
    bellBtn.tintColor = .white
    bellBtn.translatesAutoresizingMaskIntoConstraints = false
    bellBtnView.addSubview(bellBtn)
    
    NSLayoutConstraint.activate([
      bellBtn.widthAnchor.constraint(equalToConstant: 30),
      bellBtn.heightAnchor.constraint(equalToConstant: 30),
      bellBtn.leadingAnchor.constraint(equalTo: bellBtnView.leadingAnchor),
      bellBtn.topAnchor.constraint(equalTo: bellBtnView.topAnchor)
    ])
    
    bellBtnView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      bellBtnView.widthAnchor.constraint(equalToConstant: 30),
      bellBtnView.heightAnchor.constraint(equalToConstant: 30)
    ])
    
    let bellBarButton = UIBarButtonItem(customView: bellBtnView)
    
    var rightButtons = navigationItem.rightBarButtonItems ?? []
    rightButtons.append(cartBarButton)
    rightButtons.append(bellBarButton)
    rightButtons.append(UIBarButtonItem.fixedSpace(10))
    navigationItem.rightBarButtonItems = rightButtons
  }
  
  /// 카테고리 버튼 설정
  func setupCategoryButtons(){
    categoryDatas.forEach { aData in
      categoryStackView.addArrangedSubview(
        CategoryButtonView(categoryName: aData.categoryName, btnSelected: aData.btnSelected)
      )
    }
    categoryStackView.addArrangedSubview(UIView())
  }
  
  
  @objc func onCartBtnClicked(_ sender: Any) {
    print(#fileID, #function, #line," - ")
    
    self.performSegue(withIdentifier: "CartViewController", sender: nil)
  }
  
}


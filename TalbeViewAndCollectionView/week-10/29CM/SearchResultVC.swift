//
//  SearchResultVC.swift
//  week-10
//
//  Created by 최용헌 on 12/23/24.
//

import UIKit

class SearchResultVC: UIViewController {
  
  var dummyDataList: [DummyDataSection] = DummyDataSection.createSections()
  
  // 검색결과 item collectionView
  @IBOutlet weak var myCollectionView: UICollectionView!
  
  // 추천 검색어 stackView
  @IBOutlet weak var myRecommendSearchStackView: UIStackView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.title = "29CM 검색결과 VC"
    
    setupCollectionView()
    setupRecommendSearchItem()
  }
  
  /// 컬렉션 뷰 초기 설정
  private func setupCollectionView() {
    // 셀 등록
    myCollectionView.register(withNib: SearchResultCell.cellID)

    myCollectionView.dataSource = self
    myCollectionView.delegate = self
   
    // 푸터 등록
    myCollectionView.register(
        CustomFooterView.self,
        forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
        withReuseIdentifier: CustomFooterView.footerID
    )
    
    if let layout = myCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
      layout.scrollDirection = .vertical
      layout.minimumLineSpacing = 5
      layout.minimumInteritemSpacing = 10
      layout.estimatedItemSize = .zero
    }
  }
  
  /// 추천검색어 셋팅
  private func setupRecommendSearchItem() {
    let titleList: [String] = [
      "추천 검색어 1", "추천 검색어 2", "추천 검색어 3", "추천 검색어 4",
      "추천 검색어 5", "추천 검색어 6", "추천 검색어 7", "추천 검색어 8"
    ]
    
    for title in titleList {
      let button = createButton(with: title)
      myRecommendSearchStackView.addArrangedSubview(button)
    }
  }
  
  /// 추천검색어 버튼 생성
  private func createButton(with title: String) -> UIButton {
    let button = UIButton()
    button.setTitle(title, for: .normal)
    button.setTitleColor(.black, for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
    button.layer.cornerRadius = 8
    return button
  }
}

// MARK: - CollectionView Data Source

extension SearchResultVC: UICollectionViewDataSource {
  
  // 섹션 갯수
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return dummyDataList.count
  }
  
  // 섹션의 아이템 갯수
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    return dummyDataList[section].items.count
  }
  
  // 셀 데이터 설정
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
   
    let item: DummyDatafor29CM = dummyDataList[indexPath.section].items[indexPath.row]

    return SearchResultCell.makeCell(collectionView: collectionView, indexPath: indexPath, item: item)
  }
  
  // 푸터 설정
  func collectionView(
    _ collectionView: UICollectionView,
    viewForSupplementaryElementOfKind kind: String,
    at indexPath: IndexPath
  ) -> UICollectionReusableView {
    // 섹션 0에만 푸터 추가
    if kind == UICollectionView.elementKindSectionFooter, indexPath.section == 0 {
      guard let footer = collectionView.dequeueReusableSupplementaryView(
        ofKind: kind,
        withReuseIdentifier: "CustomFooterView",
        for: indexPath
      ) as? CustomFooterView else { return UICollectionReusableView() }
      footer.configure(with: "추천상품자리")
      return footer
    }
    return UICollectionReusableView()
  }
}

// MARK: - CollectionView Delegate

extension SearchResultVC: UICollectionViewDelegateFlowLayout {
  // 셀 크기 설정
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    let itemWidth: CGFloat = (collectionView.bounds.width - 20) / 2
    let itemHeight: CGFloat = itemWidth * 1.6
    return CGSize(width: itemWidth, height: itemHeight)
  }
  
  // 섹션 0에 푸터 설정
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    referenceSizeForFooterInSection section: Int
  ) -> CGSize {
    return section == 0 ? CGSize(width: collectionView.bounds.width, height: 100) : .zero
  }
}

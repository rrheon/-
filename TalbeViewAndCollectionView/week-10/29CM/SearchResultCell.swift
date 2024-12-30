//
//  SearchResultCell.swift
//  week-10
//
//  Created by 최용헌 on 12/23/24.
//

import UIKit

class SearchResultCell: UICollectionViewCell {
  static let cellID: String = "SearchResultCell"
  
  var dummyData: DummyDatafor29CM? {
    didSet{
      DispatchQueue.main.async {
        self.setupCellData()
      }
    }
  }
  @IBOutlet weak var countMarkAndRateStackViewTopConstraint: NSLayoutConstraint!
  
  @IBOutlet weak var countRateLabel: UILabel!
  @IBOutlet weak var countLikeLabel: UILabel!
  @IBOutlet weak var couponView: UIView!
  @IBOutlet weak var freeDeliveryView: UIView!
  @IBOutlet weak var itemPriceLabel: UILabel!
  @IBOutlet weak var salePercentLabel: UILabel!
  @IBOutlet weak var itemNameLabel: UILabel!
  @IBOutlet weak var markImageView: UIImageView!
  @IBOutlet weak var brandNameLabel: UILabel!
  
  @IBOutlet weak var couponAndFreeDeliveryStackView: UIStackView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    resetCellUI()
  }
  
  /// 셀 UI 초기화
  private func resetCellUI() {
    couponView.isHidden = true
    freeDeliveryView.isHidden = true
    couponAndFreeDeliveryStackView.isHidden = true
    countMarkAndRateStackViewTopConstraint.constant = 10
  }
  
  /// 셀 데이터 설정
  func setupCellData() {
    guard let data = dummyData else { return }
    
    // 브랜드 및 아이템 정보 설정
    brandNameLabel.text = data.brandName
    itemNameLabel.text = data.itemName
    salePercentLabel.text = "\(data.salePercent)%"
    itemPriceLabel.text = "\(data.itemPrice)원"
    
    // 좋아요 수 및 평점 수 설정
    countLikeLabel.text = "\(data.countMakred)"
    countRateLabel.text = "\(data.itemRate) (\(data.countReview))"
    
    // 좋아요 여부 설정
    let imageName = data.isMarked ? "heart.fill" : "heart"
    markImageView.image = UIImage(systemName: imageName)
    
    // 쿠폰 및 무료 배송
    couponView.isHidden = !data.isCouponValid
    freeDeliveryView.isHidden = !data.isFreeDelivery
    
    // 스택 뷰 및 제약 업데이트
    if data.isCouponValid || data.isFreeDelivery {
      couponAndFreeDeliveryStackView.isHidden = false
      countMarkAndRateStackViewTopConstraint.constant = 45
    } else {
      couponAndFreeDeliveryStackView.isHidden = true
      countMarkAndRateStackViewTopConstraint.constant = 10
    }
  }
  
  
  /// 셀 생성
  /// - Parameters:
  ///   - collectionView: 적용할 collectionView
  ///   - indexPath: indexPath
  ///   - item: item
  /// - Returns: SearchResultCell
  class func makeCell(
    collectionView : UICollectionView,
    indexPath: IndexPath,
    item: DummyDatafor29CM
  ) -> UICollectionViewCell{
    
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: SearchResultCell.cellID,
      for: indexPath
    ) as? SearchResultCell else { return UICollectionViewCell() }
    
    cell.dummyData = item
    return cell
  }
}

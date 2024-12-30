//
//  CustomFooterView.swift
//  week-10
//
//  Created by 최용헌 on 12/25/24.
//

import UIKit


class CustomFooterView: UICollectionReusableView {
  static let footerID: String = "CustomFooterView"

  private let footerLabel: UILabel = {
    let label = UILabel()
    label.textColor = .black
    label.font = UIFont.systemFont(ofSize: 16)
    label.textAlignment = .center
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  /// 푸터 설정
  private func setupViews() {
    addSubview(footerLabel)
    footerLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      footerLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      footerLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
    ])
  }

  
  /// 푸터 라벨에 text 설정
  /// - Parameter text: text
  func configure(with text: String) {
    footerLabel.text = text
  }
}

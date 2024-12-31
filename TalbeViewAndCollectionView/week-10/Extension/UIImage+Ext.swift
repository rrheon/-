//
//  UIImage+Ext.swift
//  week-10
//
//  Created by 최용헌 on 12/31/24.
//

import UIKit

extension UIImage {
  
  
  /// 이미지 생성 with 색상, 크기
  /// - Parameters:
  ///   - color: 이미지 색상
  ///   - size: 이미지 크기
  convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
    let rect = CGRect(origin: .zero, size: size)
    
    // 그래픽스 컨텍스트 시작(캔버스 역할)
    UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
    color.setFill() // 색상 채울준비
    UIRectFill(rect) // 해당영역을 색상으로 채움
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext() // 종료
    
    guard let cgImage = image?.cgImage else { return nil }
    self.init(cgImage: cgImage)
    
  }
}

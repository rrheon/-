//
//  ViewModel.swift
//  Bunjang-CloneCoding
//
//  Created by 최용헌 on 11/6/24.
//

import Foundation
import Combine

final class ViewModel {
  static var shared = ViewModel()
  
  var cancellabels = Set<AnyCancellable>()
  var selectedCategory = CurrentValueSubject<String?, Never>("카테고리")

  func getButtonTitle(title: String){
    selectedCategory.send(title)
  }
}

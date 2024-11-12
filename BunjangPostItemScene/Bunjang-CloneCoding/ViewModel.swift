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
  var selectedCategory = CurrentValueSubject<String?, Never>(nil)
  var itemStatus = CurrentValueSubject<String?, Never>("필수사항")

  var showPopupVC = CurrentValueSubject<Bool?, Never>(nil)
  var changeCategoryButtonTapped = CurrentValueSubject<Bool?, Never>(nil)
  var changeStatusButtonTapped = CurrentValueSubject<Bool?, Never>(nil)
  
  func getButtonTitle(title: String){
    selectedCategory.send(title)
  }
  
  func changeItemStatus(){
    changeStatusButtonTapped.send(true)
  }
}

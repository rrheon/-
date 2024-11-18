//
//  LoginCase.swift
//  NaverLogin
//
//  Created by 최용헌 on 11/18/24.
//

import Foundation

/// 로그인 시 alert 라벨 상태 실패/성공 case
enum AlertLabelContentCase {
  case idError
  case passwordError
  case failToLogin
  
  var message: String {
    switch self {
    case .idError:
      return "아이디를 입력해 주세요!"
    case .passwordError:
      return "비밀번호를 입력해 주세요!"
    case .failToLogin:
     return "어아다(로그인 전화번호, 로그인 전용 아이디) 또는 비밀번호가 잘못되었습니다. 아이디와 비밀번호를 정확히 입력 해 주세요."
    }
  }
}


/// 로그인 시 실패/성공 case
enum LoginValidationCase {
  case idEmpty
  case passwordEmpty
  case successToLogin
  case failToLogin
  
  static func validate(
    id: String,
    password: String,
    loginMockup: (id: String, password: String)
  ) -> LoginValidationCase {
    if id.isEmpty {
      return .idEmpty
    } else if password.isEmpty {
      return .passwordEmpty
    } else if id == loginMockup.id && password == String(loginMockup.password) {
      return .successToLogin
    } else {
      return .failToLogin
    }
  }
}

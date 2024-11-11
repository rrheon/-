//
//  main.swift
//  Calculator
//
//  Created by 최용헌 on 11/10/24.
//

import Foundation

enum mode: String {
  case calculate = "calculate"
  case record = "record"
  case exit = "exit"
}

enum calMode: String {
  case plus = "plus"
  case minus = "minus"
  case multiply = "multiply"
  case divide = "divide"
  case menu = "menu"
}

enum recordMode: String {
  case deleteItem = "deleteItem"
  case deleteAll = "deleteAll"
  case menu = "menu"
  
}

var calculateRecord: [String] = []
var isContinueCalcualte: Bool = true

while isContinueCalcualte {
  selectMenuMode()
}

// TODO: 메뉴모드

func selectMenuMode(){
  print("메뉴를 선택하세요\n[계산모드], [기록모드], [종료모드]")
  if let selectedMode: mode = mode(rawValue: String(readLine()!)) {
    switch selectedMode {
    case .calculate:
      selectCalculateMode()
    case .record:
      recordsMode()
    case .exit:
      isContinueCalcualte = false
    }
  } else {
    print("잘못 입력")
  }
}

// TODO: 계산모드

func selectCalculateMode(){
  print("[계산]이 선택되었다\n[계산모드]에 진입되었습니다\n수를 입력하세요")
  let number1: Int = Int(readLine()!)!
  
  print("계산을 선택해주세요!\nplus[더하기],minus[빼기],multiply[곱하기], divide[나누기]")
  if let calMode: calMode = calMode(rawValue: readLine()!) {
    print("나머지 수를 입력해주세요!")
    let number2: Int = Int(readLine()!)!
    var result: String = ""
    
    switch calMode {
    case .plus:
      result = "\(number1) + \(number2) = \(number1 + number2)"
    case .minus:
       result = "\(number1) - \(number2) = \(number1 - number2)"
    case .multiply:
      result = "\(number1) x \(number2) = \(number1 * number2)"
    case .divide:
      result = "\(number1) / \(number2) = \(number1 / number2)"
    case .menu:
      selectMenuMode()
    }
    
    printAndSaveCalculateResult(result: result)
    selectMenuMode()
  }else{
    print("잘못 입력")
  }
}

func printAndSaveCalculateResult(result: String){
  print("[계산 결과입니다] \(result)")
  calculateRecord.append("\([calculateRecord.count + 1]) \(result)")
}

// TODO: 기록모드

func recordsMode(){
  print("[계산기록]이 선택되었다!")
  print("[기록모드]에 진입되었다!")
  
  for i in calculateRecord {
    print(i)
  }
  
  print("기록 액션을 선택해주세요!")
  
  if let recordMode = recordMode(rawValue: readLine()!) {

    switch recordMode {
      
    case .deleteItem:
      print("삭제할 번호를 선택해주세요!")
      let num = Int(readLine()!)!
      calculateRecord.remove(at: num)
    case .deleteAll:
     print("모든 기록을 삭제합니다!")
      calculateRecord.removeAll()
    case .menu:
      selectMenuMode()
    }
    selectMenuMode()
  }else {
    print("잘못입력")
  }
 
}


import Foundation

import Fakery

// MARK: - cafe data list

struct CafeDummyDataSection {
  let uuid: UUID
  
  var rows: [CafeDummyData]
  
  init() {
    self.uuid = UUID()
    self.rows = CafeDummyData.getDummies(11)
  }
  
  static func getDummies(_ count: Int = 3) -> [CafeDummyDataSection]{
    return (1...count).map { _ in CafeDummyDataSection() }
  }
}

struct CafeDummyData {
  let uuid: UUID
  
  var seenPost: Bool
  var postTitle: String
  let postPhoto: String
  let countPostPhoto: Int
  let countComment: Int
  let userLevel: Int
  let userName: String
  let postedDate: String
  
  init() {
    self.uuid = UUID()
    
    let faker = Faker(locale: "ko")
    
    self.seenPost = faker.number.randomBool() // 최신글 여부
    self.postTitle = faker.lorem.sentence() // 게시글 제목
    self.postPhoto = faker.internet.url() // 게시글 사진 URL
    self.countPostPhoto = Int.random(in: 1...10) // 게시글 사진 수
    self.countComment = Int.random(in: 0...100) // 댓글 수
    self.userLevel = Int.random(in: 1...10) // 유저 등급
    self.userName = faker.name.name() // 유저 네임
    self.postedDate = CafeDummyData.getTimeAndData() // 게시한 날짜
  }
  
  static func getDummies(_ count: Int = 10) -> [CafeDummyData]{
    return (1...count).map { _ in CafeDummyData() }
  }
  
  static func getTimeAndData() -> String{
    let now = Date()
    
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "ko_KR")
    formatter.timeZone = TimeZone.current
    formatter.dateFormat = "yy-MM-dd HH:mm"
    
    let currentTime = formatter.string(from: now)
    return currentTime
  }
}

// MARK: - 29CM data list

struct DummyDataSection {
  let items: [DummyDatafor29CM]
  
  static func createSections() -> [DummyDataSection] {
    // 각 섹션별 아이템 생성 : 첫 섹션 아이템 4개 이후 추천 아이템? 붙음
    let section1Items = DummyDatafor29CM.getDummies(4)
    let section2Items = DummyDatafor29CM.getDummies(11)
    
    let section1 = DummyDataSection(items: section1Items)
    let section2 = DummyDataSection(items: section2Items)
    
    return [section1, section2]
  }
}

struct DummyDatafor29CM {
  let uuid: UUID
  
  let isMarked: Bool
  let brandName: String
  let itemName: String
  let salePercent: Int
  let itemPrice: Int
  let countMakred: Int
  let itemRate: Int
  let countReview: Int
  let isOnly29CM: Bool
  let isCouponValid: Bool
  let isFreeDelivery: Bool
  let isEventValid: Bool
  
  init() {
    self.uuid = UUID()
    
    let faker = Faker(locale: "ko")
    
    self.isMarked = faker.number.randomBool() // 찜 여부
    self.brandName = faker.company.name() // 브랜드 이름
    self.itemName = faker.commerce.productName() // 아이템 이름
    self.salePercent = faker.number.randomInt(min: 0, max: 70) // 할인률
    self.itemPrice = faker.number.randomInt(min: 1000, max: 1000000) // 가격 설정
    self.countMakred = faker.number.randomInt(min: 0, max: 10000) // 찜 갯수
    self.itemRate = faker.number.randomInt(min: 0, max: 5) // 평균 리뷰
    self.countReview = faker.number.randomInt(min: 0, max: 1000) // 리뷰 갯수
    self.isOnly29CM = faker.number.randomBool()
    self.isCouponValid = faker.number.randomBool() // 쿠폰적용 여부
    self.isFreeDelivery = faker.number.randomBool() // 무료배송 여부
    self.isEventValid = faker.number.randomBool() // 이벤트 여부
  }
  
  static func getDummies(_ count: Int = 10) -> [DummyDatafor29CM]{
    return (1...count).map { _ in DummyDatafor29CM() }
  }
}



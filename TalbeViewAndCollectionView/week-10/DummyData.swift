
import Foundation

import Fakery

struct DummySection {
  let uuid: UUID

  var rows: [DummyData]
  
  init() {
    self.uuid = UUID()
    self.rows = DummyData.getDummies(11)
  }
  
  static func getDummies(_ count: Int = 3) -> [DummySection]{
    return (1...count).map { _ in DummySection() }
  }
}

struct DummyData {
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
    self.postedDate = DummyData.getTimeAndData() // 게시한 날짜
  }
  
  static func getDummies(_ count: Int = 10) -> [DummyData]{
    return (1...count).map { _ in DummyData() }
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




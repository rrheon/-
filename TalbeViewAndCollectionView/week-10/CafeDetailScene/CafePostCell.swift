//
//  CafePostCell.swift
//  week-10
//
//  Created by 최용헌 on 12/17/24.
//

import UIKit

class CafePostCell: UITableViewCell {
  
  var dummyData: DummyData? {
    didSet{
      DispatchQueue.main.async {
        self.setupCellData()
      }
    }
  }
  
  var commentBtnAction: ((UUID) -> Void)? = nil
  
  // 최신글 앞에 붙는 이미지 - 조회하면 사라짐
  @IBOutlet weak var checkRecentPostImageView: UIImageView!
  
  // 게시글 제목
  @IBOutlet weak var postTitleLabel: UILabel!
  
  // 유저닉네임
  @IBOutlet weak var userNicknameLabel: UILabel!
  
  // 유저 등급
  @IBOutlet weak var userLevelImageView: UIImageView!
  
  // 게시된 시간 or 날짜
  @IBOutlet weak var postedTimeLabel: UILabel!
  
  // 조회수
  @IBOutlet weak var countLabel: UILabel!
  
  // 게시글 이미지(첫번째 이미지)
  @IBOutlet weak var postPhotoImageView: UIImageView!
  
  // 게시된 이미지의 수
  @IBOutlet weak var countPhotoLabel: UILabel!
  
  // 게시글의 댓글 수
  @IBOutlet weak var countCommentLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    print(#fileID, #function, #line," - <#comment#>")
    
    self.selectionStyle = .none

  }
  
  /// cell에 데이터 셋팅
  func setupCellData(){
    guard let cellData = dummyData else { return }
    
    checkRecentPostImageView.isHidden = cellData.seenPost
    if cellData.seenPost {
      postTitleLabel.textColor = .lightGray
    }
    
    postTitleLabel.text = cellData.postTitle
    postTitleLabel.textAlignment = .natural
    userNicknameLabel.text = cellData.userName
    userLevelImageView.image = UIImage(systemName: "\(cellData.userLevel).square.fill")
    postedTimeLabel.text = returnDateData()
    countLabel.text = "조회 \(cellData.countComment)"
    countPhotoLabel.text = "\(cellData.countPostPhoto)+"
    countCommentLabel.text = String(cellData.countComment)
  }
  
  /// 게시글 작성 시간/ 날짜 반환
  /// - Returns:게시글 작성 날짜가 현재 날짜와 같다면 작성 시간 반환, 아니면 날짜반환
  func returnDateData() -> String{
    let currentDate = DummyData.getTimeAndData().split(separator: " ")
    guard let postedDate = dummyData?.postedDate.split(separator: " ") else { return "" }
    
    return currentDate[0] == postedDate[0] ? String(postedDate[1]) : String(postedDate[0])
  }
  
  
  /// 댓글 버튼 터치
  /// - Parameter sender: 댓글 버튼
  @IBAction func onCommentBtnClicked(_ sender: UIButton) {
    if let action =  commentBtnAction,
       let postID = dummyData?.uuid {
      action(postID)
    }
  }
}

//
//  CafeDetailVC.swift
//  week-10
//
//  Created by 최용헌 on 12/17/24.
//

import UIKit

class CafeDetailVC: UIViewController {
  
  @IBOutlet weak var myTableView: UITableView!
  
  var dummyDataList: [CafeDummyDataSection] = CafeDummyDataSection.getDummies()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureTableView()
  }
  
  
  /// tableView 셋팅
  private func configureTableView() {
    let cellNib = UINib(nibName: "CafePostCell", bundle: nil)
    self.myTableView.register(cellNib, forCellReuseIdentifier: "CafePostCell")
    self.myTableView.dataSource = self
    self.myTableView.delegate = self
    
    self.myTableView.tableHeaderView = UIView(frame: .zero)
    self.myTableView.sectionHeaderHeight = 0
  }
}

// MARK: - tableview DataSource
extension CafeDetailVC: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return dummyDataList.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dummyDataList[section].rows.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: "CafePostCell",
      for: indexPath
    ) as? CafePostCell else { return UITableViewCell() }
    
    let sectionData: CafeDummyDataSection = dummyDataList[indexPath.section]
    let cellData: CafeDummyData = sectionData.rows[indexPath.row]
    
    cell.dummyData = cellData
    cell.commentBtnAction = { postID in
      let vc = CommentDetailVC.instantiate("CafeDetailVC")
      self.navigationController?.pushViewController(vc, animated: true)
    }
    
    return cell
  }
}

// MARK: - tableview Delegate
extension CafeDetailVC: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100.0
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let sectionData: CafeDummyDataSection = dummyDataList[indexPath.section]
    var cellData: CafeDummyData = sectionData.rows[indexPath.row]
    print(#fileID, #function, #line," - \(cellData.postTitle)")
    
    // 게시글 선택했을 때 이미 본 게시글로 전환
    self.dummyDataList[indexPath.section].rows[indexPath.row].seenPost = true
    self.myTableView.reloadData()


    let vc = PostDetailVC.instantiate("CafeDetailVC")
    
    // 삭제 action
    vc.onDeletePostAction = {
      self.dummyDataList[indexPath.section].rows.removeAll { $0.uuid == cellData.uuid }
      self.myTableView.reloadData()
    }
    
    // 게시글 추가 action
    vc.onAddPostAction = {
      let newData = CafeDummyData.getDummies(1)

      self.dummyDataList[indexPath.section].rows.insert(contentsOf: newData, at: 0)
      print(#fileID, #function, #line," - 추가된 데이터: \(newData)")
      self.myTableView.reloadData()
    }

    self.navigationController?.pushViewController(vc, animated: true)
  }
  
  // 각 섹션 아래에 광고 뷰 높이 설정
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 100.0
  }
  
  // 각 섹션 아래에 광고 뷰 추가
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    let adView = UIView()
    adView.backgroundColor = .blue
    
    let label = UILabel()
    label.text = "광고 \(section + 1)"
    label.textAlignment = .center
    label.textColor = .white
    label.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 100)
    adView.addSubview(label)
    
    return adView
  }
}

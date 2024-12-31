//
//  AlaramViewController.swift
//  week-10
//
//  Created by 최용헌 on 12/30/24.
//

import UIKit

class AlaramComponentViewController: UIViewController {
  
  @IBOutlet weak var myLabel: UILabel!
  
  var alaramTitle: String?
  
  init?(coder: NSCoder, title: String = "") {
    super.init(coder: coder)
    self.alaramTitle = title
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.myLabel.text = alaramTitle
    }
}

// MARK: - Helpers
extension AlaramComponentViewController{
  
  /// AlaramVC 생성 with 제목
  /// - Parameter title: 제목
  /// - Returns:AlaramVC
  class func getInstace(title: String) -> AlaramComponentViewController {
    let storyboard = UIStoryboard(name: String(describing: AlaramComponentViewController.self),
                                  bundle: .main)
    
    let alaramVC = storyboard.instantiateInitialViewController { nscoder in
      return AlaramComponentViewController(coder: nscoder, title: title)
    }!
    return alaramVC
  }
}

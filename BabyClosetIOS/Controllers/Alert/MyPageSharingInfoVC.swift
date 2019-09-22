//
//  MyPageSharingInfoVC.swift
//  BabyClosetIOS
//
//  Created by 박경선 on 03/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

import UIKit

class MyPageSharingInfoVC: UIViewController {
    
    var blackView = UIView()
    var CompleteData: CompleteShare?
    var nickname = ""
    let networkManager = NetworkManager()
    var userIdx: Int?
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet var stars: [UIImageView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserDetailNetwork()
        view.backgroundColor = UIColor(white: 0.2, alpha: 0.4)
        view.isOpaque = false
        let height = profileImg.frame.height / 2
        profileImg.roundCorners(corners: [.allCorners], radius: height)
        
    }
    
    func getUserDetailNetwork(){
        print("\n\n\n dddddddd \n\n\n")
        guard let userIdx = userIdx else {
            print("\n\n\n errorerrorerrorerror \n\n\n")
            return }
        networkManager.getOtherUserInfo (userIdx: userIdx){ [weak self] (success, error) in
            print("success  : ", success)
            if success == nil && error != nil {
                self?.simpleAlert(title: "", message: "네트워크 오류입니다.")
            }
            else if success != nil && error == nil {
                guard success?.success ?? false else {
                    if let msg = success?.message {
                        self?.simpleAlert(title: "", message: msg)
                    }
                    return
                }
                if let nickname = success?.data?.nickname,
                    let star = success?.data?.rating,
                    let img = success?.data?.profileImage?.urlToImage() {
                    let attributedString = NSMutableAttributedString()
                        .normal("\(nickname)님", font: UIFont.B16)
                        .normal("의 별점", font: UIFont.L16)
                        .normal("\(star)점", font: UIFont.B16)
                    self?.label.attributedText = attributedString
                    self?.profileImg = UIImageView(image: img)
                    self?.fillStar(star)
                }
            }
        }
    }
    
    @IBAction func allowAction(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    func fillStar(_ star: Int) {
        for i in 0 ... stars.count - 1 {
            stars[i].image = UIImage(named: "emptyStar64")
        }
        for i in 0 ... star - 1 {
            stars[i].image = UIImage(named: "star64")
        }
    }
    
}

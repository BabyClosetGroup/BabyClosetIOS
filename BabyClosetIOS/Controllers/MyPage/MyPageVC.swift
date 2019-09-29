//
//  MyPageVC.swift
//  BabyClosetIOS
//
//  Created by 박경선 on 02/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

import UIKit

class MyPageVC: UIViewController {
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    let networkManager = NetworkManager()
    var nickname = "nickname"
    let star = 4
    
    @IBOutlet var stars: [UIImageView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = UIColor.gray38
        navigationController?.navigationBar.barTintColor = UIColor.white
        let attributedString = NSMutableAttributedString()
            .normal("정보를 가지고 오는 중입니다.", font: UIFont.M16)
        self.infoLabel.attributedText = attributedString
        profileImg.roundCorners(corners: [.allCorners], radius: 31)
        profileImg.contentMode = .scaleToFill
        
    }
    
    func getUserDetailNetwork(){
        let userIdx = UserDefaults.standard.integer(forKey: "userIdx")
        networkManager.getOtherUserInfo (userIdx: userIdx){ [weak self] (success, error) in
            if success == nil && error != nil {
                self?.simpleAlert(title: "", message: "네트워크 오류입니다.")
            }
            else {
                guard (success?.success)! else {
                    if let msg = success?.message {
                        self?.simpleAlert(title: "", message: msg)
                    }
                    return
                }
                if let nickname = success?.data?.nickname,
                    let star = success?.data?.rating {
                    let attributedString = NSMutableAttributedString()
                        .normal("\(nickname)님", font: UIFont.B16)
                        .normal("의 별점 ", font: UIFont.L16)
                        .normal("\(star)점", font: UIFont.B16)
                    self?.infoLabel.attributedText = attributedString
                    
                    self?.fillStar(Int(star))
                    if let img = success?.data?.profileImage?.urlToImage() {
                        self?.profileImg.image = img
                    } else {
                        self?.profileImg.image = UIImage(named: "myPageDefault")
                    }
                    print(nickname)
                }
            }
        }
    }
    @IBAction func shareGoods(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyPageShareVC") as! MyPageShareVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.shouldRemoveShadow(false)
        self.navigationItem.title = "마이페이지"
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.B17]
        getUserDetailNetwork()
    }
    
    func fillStar(_ star: Int) {
        for i in 0 ... stars.count - 1 {
            stars[i].image = UIImage(named: "emptyStar64")
        }
        if star != 0 {
            for i in 0 ... star - 1 {
                stars[i].image = UIImage(named: "star64")
            }
        }
    }
}

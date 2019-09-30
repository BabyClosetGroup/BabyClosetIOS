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
    var receiveIdx: Int?
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet var stars: [UIImageView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserDetailNetwork()
//        view.backgroundColor = UIColor(white: 0.2, alpha: 0.4)
//        view.isOpaque = false
        let height = profileImg.frame.height / 2
        profileImg.roundCorners(corners: [.allCorners], radius: height)
    }
    
    func getUserDetailNetwork(){
        networkManager.getOtherUserInfo (userIdx: gino(receiveIdx)){ [weak self] (success, error) in
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
                    let star = success?.data?.rating {
                    let attributedString = NSMutableAttributedString()
                        .normal("\(nickname)님", font: UIFont.B16)
                        .normal("의 별점 ", font: UIFont.L16)
                        .normal("\(star)점", font: UIFont.B16)
                    self?.label.attributedText = attributedString
                    self?.fillStar(Int(star))
                }
                if let img = success?.data?.profileImage?.urlToImage() {
                    self?.profileImg.image = img
                } else {
                    self?.profileImg.image = UIImage(named: "myPageDefault")
                }
            }
        }
    }

    @IBAction func allowAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CustomizedTabBarController") as! CustomizedTabBarController
        let sb = UIStoryboard(name: "MyPage", bundle: nil)
        let nvc = sb.instantiateViewController(withIdentifier: "MyPage") as! UINavigationController
        let dvc = sb.instantiateViewController(withIdentifier: "MyPageShareVC") as! MyPageShareVC
        self.view.window?.rootViewController = vc
        vc.viewControllers?[1].present(nvc, animated: false) {
            nvc.pushViewController(dvc, animated: false)
        }
        
    }
    
    func fillStar(_ star: Int) {
        for i in 0 ... stars.count - 1 {
            stars[i].image = UIImage(named: "emptyStar64")
        }
        for i in 0 ... star - 1 {
            stars[i].image = UIImage(named: "star64")
        }
    }
//    @IBAction func allowAction(_ sender: Any) {
//        dismiss(animated: true, completion: nil)
//
//    }
    @IBAction func allowAction(_ sender: Any) {
        let nv = self.storyboard?.instantiateViewController(withIdentifier: "MyPage")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyPageShareVC") as! MyPageShareVC
        self.present(nv!, animated: false, completion: nil)

    }
    
    
    
    
}

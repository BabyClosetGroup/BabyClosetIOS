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
    let nickname = "정미"
    let star = 3
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet var stars: [UIImageView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0.2, alpha: 0.4)
        view.isOpaque = false
        
        let attributedString = NSMutableAttributedString()
            .normal("\(nickname)님", font: UIFont.B16)
            .normal("의 별점", font: UIFont.L16)
            .normal("\(star)점", font: UIFont.B16)
        label.attributedText = attributedString
        
        let height = profileImg.frame.height / 2
        profileImg.roundCorners(corners: [.allCorners], radius: height)
        
        fillStar()
    }
    
    
    @IBAction func allowAction(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    func fillStar() {
        for i in 0 ... stars.count - 1 {
            stars[i].image = UIImage(named: "emptyStar64")
        }
        for i in 0 ... star - 1 {
            stars[i].image = UIImage(named: "star64")
        }
    }
}

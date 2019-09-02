//
//  MyPageVC.swift
//  BabyClosetIOS
//
//  Created by 박경선 on 02/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

import UIKit

class MyPageVC: UIViewController {
    
    @IBOutlet weak var infoLabel: UILabel!
    let nickname = "정미"
    let star = 5
    
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    @IBOutlet var stars: [UIImageView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillStar()
        
        self.navigationController?.navigationBar.tintColor = UIColor.darkGray
        navigationController?.navigationBar.barTintColor = UIColor.white
        
        let attributedString = NSMutableAttributedString()
            .normal(nickname, font: UIFont.B16)
            .normal("님의 별점 ", font: UIFont.L16)
            .normal("\(star)점", font: UIFont.B16)
        infoLabel.attributedText = attributedString
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "마이페이지"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.B17]
    }
    
    func fillStar() {
        for i in 0 ... star-1 {
            stars[i].image = UIImage(named: "star")
        }
        for i in star-1 ... stars.count - 1 {
            stars[i].image = UIImage(named: "emptyStar")
        }
    } 
}
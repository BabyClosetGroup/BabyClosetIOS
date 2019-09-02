//
//  MyPageStarVC.swift
//  BabyClosetIOS
//
//  Created by 박경선 on 02/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

import UIKit

class MyPageStarVC: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    let nickname = "정미"
    let product = "3개월 아기바지"
    var rating = 0
    @IBOutlet var stars: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.numberOfLines = 0
        
        let attributedString = NSMutableAttributedString()
            .normal("\(nickname)님", font: UIFont.EB22)
            .normal("과의\n", font: UIFont.L22)
            .normal(product, font: UIFont.EB22)
            .normal("\n나눔은 어떠셨나요?", font: UIFont.L22)
        label.attributedText = attributedString
        
    }
    
    @IBAction func starAction(_ sender: UIButton) {
        
        for i in 0 ... 4 {
            stars[i].setImage(UIImage(named: "btn-emptyStar"), for: .normal)
        }
        
        switch sender {
        case stars[0]:
            rating = 1
        case stars[1]:
            rating = 2
        case stars[2]:
            rating = 3
        case stars[3]:
            rating = 4
        default:
            rating = 5
        }
        
        for i in 0 ... rating-1 {
            stars[i].setImage(UIImage(named: "btn-star"), for: .normal)
            
        }
    }
    
    @IBAction func ratingAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
        // 대충 서버에게 별점 몇 개 줬는지 알려주는 기능
    }
    
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

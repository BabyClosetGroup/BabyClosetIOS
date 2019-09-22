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
    var userIdx: Int?
    var postIdx: Int?
    var rating: Int = 0
    let networkManager = NetworkManager()
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
         getNetwork()
    }
    
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func getNetwork(){
        print("\n\n\n abcdefghijklmnop \n\n")
        guard let userIdx = userIdx else { return }
        guard let postIdx = postIdx else { return }
        networkManager.saveRating(userIdx: userIdx, rating: rating, postIdx: postIdx){ [weak self] (success, error) in
            print("success  : ", success)
            if success == nil && error != nil {
                self?.simpleAlert(title: "", message: "네트워크 오류입니다.")
            }
            else if success != nil && error == nil {
                guard let stat = success?.status, stat < 300 else {
                    if let msg = success?.message {
                        self?.simpleAlert(title: "", message: msg)
                    }
                    return
                }
            }
        }
    }
    
}

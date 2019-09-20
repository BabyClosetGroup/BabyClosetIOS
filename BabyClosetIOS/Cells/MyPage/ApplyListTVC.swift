//
//  ApplyListTVC.swift
//  BabyClosetIOS
//
//  Created by 박경선 on 03/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

import UIKit

class ApplyListTVC: UITableViewCell {

    var nickname = "정미"
    var star = 4
    
    @IBOutlet var profileImg: UIView!
    @IBOutlet weak var starLabel: UILabel!
    @IBOutlet var stars: [UIImageView]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func fillStar(){
        for i in 0 ... stars.count - 1 {
            stars[i].image = UIImage(named: "emptyStar64")
        }
        
        for i in 0 ... star - 1 {
            stars[i].image = UIImage(named: "star64")
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

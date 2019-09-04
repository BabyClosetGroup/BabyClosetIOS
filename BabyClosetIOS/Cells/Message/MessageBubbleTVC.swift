//
//  MessageBubbleTVC.swift
//  BabyClosetIOS
//
//  Created by 박경선 on 03/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

import UIKit

class MessageBubbleTVC: UITableViewCell {
    
    @IBOutlet weak var bubble: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    var bubbleHeightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentLabel.numberOfLines = 0
        bubble.layer.masksToBounds = true
        selectionStyle = .none
//        bubble.roundCorners(corners: [.topRight, .topLeft, .bottomLeft], radius: 15)
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

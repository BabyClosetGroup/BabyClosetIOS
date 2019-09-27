//
//  MessageBubbleTVC.swift
//  BabyClosetIOS
//
//  Created by 박경선 on 03/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

import UIKit

class MessageBubbleTVC: UITableViewCell {
    
    let bubble: UIImageView = {
        //        let view = UIView()
        let imgView = UIImageView()
        imgView.image = UIImage(named: "grayBubble")!.resizableImage(withCapInsets:
            UIEdgeInsets(top: 22, left: 26, bottom: 22, right: 26), resizingMode: .stretch).withRenderingMode(.alwaysOriginal)
        
        //        view.addSubview(imgView)
        return imgView
    }()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UITextView!
//    var bubbleHeightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addSubview(bubble)
        bubble.frame.size.width = 343
        bubble.centerXAnchor.constraint(equalTo:self.centerXAnchor).isActive = true
        bubble.centerYAnchor.constraint(equalTo:self.centerYAnchor).isActive = true
        selectionStyle = .none
        //        bubble.roundCorners(corners: [.topRight, .topLeft, .bottomLeft], radius: 15)
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

//
//  MessageListTVC.swift
//  BabyClosetIOS
//
//  Created by 박경선 on 03/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

import UIKit

class MessageListTVC: UITableViewCell {

    @IBOutlet weak var other: UILabel!
    @IBOutlet weak var shortMsg: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var unreadCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

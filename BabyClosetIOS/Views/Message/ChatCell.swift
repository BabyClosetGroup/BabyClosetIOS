//
//  ChatCell.swift
//  BabyClosetIOS
//
//  Created by 박경선 on 28/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

import UIKit

class ChatCell: BaseCell {
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        return view
    }()
    
    let typeLabel: UILabel = {
        let label = UILabel()
        label.text = "받은 쪽지"
        label.textColor = UIColor.gray112
        label.font = UIFont.M12
        return label
    }()
    
    let messageView: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.backgroundColor = UIColor.clear
        textView.text = "Your friend's message and something else..."
        textView.textColor = UIColor.gray38
        textView.font = UIFont.M15
        return textView
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "19/09/18 12:05"
        label.font = UIFont.M12
        label.textColor = UIColor.gray219
        label.textAlignment = .right
        return label
    }()
    
    var bubble: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "grayBubble")!.resizableImage(withCapInsets: UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24), resizingMode: .stretch).withRenderingMode(.alwaysOriginal)
        return imgView
    }()
    
    override func setupViews() {
        setupContainerView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    private func setupContainerView() {
        let containerView = UIView()
        addSubview(containerView)
        addSubview(bubble)
        addConstraintsWithFormat(format: "H:|-16-[v0]|", views: containerView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: containerView)
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: bubble)
        addConstraintsWithFormat(format: "V:|-6-[v0]|", views: bubble)
        bubble.addSubview(typeLabel)
        bubble.addSubview(messageView)
        bubble.addSubview(timeLabel)
        
        bubble.addConstraintsWithFormat(format: "H:|-10-[v0][v1(120)]-10-|", views: typeLabel, timeLabel)
        bubble.addConstraintsWithFormat(format: "H:|-10-[v0]-22-|", views: messageView)
        bubble.addConstraintsWithFormat(format: "V:|-10-[v0(15)]-5-[v1]|", views: typeLabel, messageView)
        bubble.addConstraintsWithFormat(format: "V:|-10-[v0(15)]", views: timeLabel)
    }
    
}

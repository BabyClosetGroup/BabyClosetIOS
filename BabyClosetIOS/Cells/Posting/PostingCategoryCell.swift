//
//  PostingCategoryCell.swift
//  BabyClosetIOS
//
//  Created by 박경선 on 05/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

import UIKit

class PostingCategoryCell: UICollectionViewCell {
    @IBOutlet weak var tagLabel: UILabel!
    var isSelectCollection = true
//    @IBOutlet weak var tabLabelWidthC: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tagLabel.roundCorners(corners: [.allCorners], radius: 8)
//        tabLabelWidthC.constant = 82
    }
    
    override var isSelected: Bool {
        didSet{
            if isSelectCollection{
                self.tagLabel.backgroundColor = isSelected ? .mainYellow : .white
                self.tagLabel.borderWidth = isSelected ? 0 : 1.5
                self.tagLabel.borderColor = isSelected ? .mainYellow : .gray118
                self.tagLabel.textColor = isSelected ? .white : .gray118
            } else {
                self.tagLabel.backgroundColor = .mainYellow
                self.tagLabel.textColor = .white
            }
        }
    }
}

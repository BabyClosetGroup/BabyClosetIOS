//
//  PostingCategoryCell.swift
//  BabyClosetIOS
//
//  Created by 박경선 on 05/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

import UIKit

class PostingCategoryCell: UICollectionViewCell {
    @IBOutlet weak var tagView: UIView!
    var isSelectCollection = true
    var tagLabel: UILabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tagLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 82, height: 28))
        self.tagView.addSubview(tagLabel)
        tagLabel.font = UIFont(name: "SeoulNamsanM", size: 14)
        tagLabel.textColor = .gray118
        tagLabel.textAlignment = .center
        tagLabel.translatesAutoresizingMaskIntoConstraints = false
        tagLabel.centerXAnchor.constraint(equalTo:tagView.centerXAnchor).isActive = true
        tagLabel.centerYAnchor.constraint(equalTo:tagView.centerYAnchor).isActive = true
    }
    
    override var isSelected: Bool {
        didSet{
            if isSelectCollection{
                self.tagView.backgroundColor = isSelected ? .mainYellow : .white
                self.tagView.borderWidth = isSelected ? 0 : 1
                self.tagView.borderColor = isSelected ? .mainYellow : .gray118
                self.tagLabel.textColor = isSelected ? .white : .gray118
            } else {
                self.tagView.backgroundColor = .mainYellow
                self.tagLabel.textColor = .white
            }
        }
    }
}



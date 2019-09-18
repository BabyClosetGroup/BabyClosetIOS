//
//  CheckBoxButton.swift
//  BabyClosetIOS
//
//  Created by 박경선 on 18/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

import UIKit

class CheckBoxButton: UIButton {
    // Images
    let checkedImage = UIImage(named: "btn-checked")
    let uncheckedImage = UIImage(named: "btn-unchecked")
    
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                self.setImage(checkedImage, for: .normal)
            } else {
                self.setImage(uncheckedImage, for: .normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.isChecked = false
    }
}

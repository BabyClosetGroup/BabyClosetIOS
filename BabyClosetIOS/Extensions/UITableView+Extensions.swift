//
//  UITableView+Extensions.swift
//  BabyClosetIOS
//
//  Created by 박경선 on 05/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

import UIKit

extension UITableView {
    
    func setBottomInset(to value: CGFloat) {
        let edgeInset = UIEdgeInsets(top: 0, left: 0, bottom: value, right: 0)
        
        self.contentInset = edgeInset
        self.scrollIndicatorInsets = edgeInset
    }
}

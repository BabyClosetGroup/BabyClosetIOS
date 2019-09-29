//
//  UITextField+Extensions.swift
//  BabyClosetIOS
//
//  Created by 박경선 on 02/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

import UIKit

extension UITextField {
    func setUnderLine( border: CALayer, color: CGColor, yPosition: CGFloat){
        border.borderColor = color
        border.borderWidth = 1.0
        border.frame = CGRect(x: 0, y: self.frame.height - yPosition, width:  self.frame.width, height: self.frame.height)
        self.layer.addSublayer(border)
        self.borderStyle = .none
        self.layer.masksToBounds = true
        //        UITextField.appearance().tintColor = UIColor.mainGreen
    }
    
    func clearButtonWithImage(_ image: UIImage) {
        let clearButton = UIButton()
        clearButton.setImage(image, for: .normal)
        clearButton.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        clearButton.contentMode = .scaleAspectFit
        clearButton.addTarget(self, action: #selector(self.clear(sender:)), for: .touchUpInside)
        self.rightView = clearButton
        self.rightViewMode = .always
    }
    
    @objc func clear(sender: AnyObject) {
        self.text = ""
    }
}


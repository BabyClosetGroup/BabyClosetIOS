//
//  NSMutableAttributedString+Extensions.swift
//  BabyClosetIOS
//
//  Created by 박경선 on 31/08/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

import Foundation
import UIKit

extension NSMutableAttributedString {
    
    func bold(_ text: String, fontSize: CGFloat) -> NSMutableAttributedString {
        let attrs: [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: fontSize)]
        self.append(NSMutableAttributedString(string: text, attributes: attrs))
        return self
    }
    
//    func normal(_ text: String, fontSize: CGFloat) -> NSMutableAttributedString {
//        let attrs: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: fontSize)]
//        self.append(NSMutableAttributedString(string: text, attributes: attrs))
//        return self
//    }
    
    func normal(_ text: String, font: UIFont) -> NSMutableAttributedString {
        let attrs: [NSAttributedString.Key: Any] = [.font: font]
        self.append(NSMutableAttributedString(string: text, attributes: attrs))
        return self
    }
    
    
    func color(_ text: String, color: UIColor, fontSize: CGFloat) -> NSMutableAttributedString {
        var attrs: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: fontSize)]
        attrs[.foregroundColor] = color
        self.append(NSMutableAttributedString(string: text, attributes: attrs))
        return self
    }
}

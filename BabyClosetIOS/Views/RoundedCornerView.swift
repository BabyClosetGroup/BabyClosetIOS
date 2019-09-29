//
//  RoundedCornerView.swift
//  BabyClosetIOS
//
//  Created by 박경선 on 04/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedCornerView: UIView {
    
    var cornerRadiusValue : CGFloat = 15
    var corners : UIRectCorner = []
    
//    @IBInspectable override public var cornerRadius : CGFloat {
//        get {
//            return cornerRadiusValue
//        }
//        set {
//            cornerRadiusValue = newValue
//        }
//    }

    @IBInspectable public var topLeft : Bool {
        get {
            return corners.contains(.topLeft)
        }
        set {
            setCorner(newValue: newValue, for: .topLeft)
        }
    }
    
    @IBInspectable public var topRight : Bool {
        get {
            return corners.contains(.topRight)
        }
        set {
            setCorner(newValue: newValue, for: .topRight)
        }
    }
    
    @IBInspectable public var bottomLeft : Bool {
        get {
            return corners.contains(.bottomLeft)
        }
        set {
            setCorner(newValue: newValue, for: .bottomLeft)
        }
    }
    
    @IBInspectable public var bottomRight : Bool {
        get {
            return corners.contains(.bottomRight)
        }
        set {
            setCorner(newValue: newValue, for: .bottomRight)
        }
    }
    
    func setCorner(newValue: Bool, for corner: UIRectCorner) {
        if newValue {
            addRectCorner(corner: corner)
        } else {
            removeRectCorner(corner: corner)
        }
    }
    
    func addRectCorner(corner: UIRectCorner) {
        corners.insert(corner)
        updateCorners()
    }
    
    func removeRectCorner(corner: UIRectCorner) {
        if corners.contains(corner) {
            corners.remove(corner)
            updateCorners()
        }
    }
    
    func updateCorners() {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: 15, height: 15))
        let mask = CAShapeLayer()
        mask.frame = self.bounds
        mask.path = path.cgPath
        self.layer.mask = mask
        self.layer.masksToBounds = true
        self.setBorder(borderColor: .mainYellow, borderWidth: 2)
    }
    
}

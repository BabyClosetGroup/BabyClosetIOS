//
//  String+Extensions.swift
//  BabyClosetIOS
//
//  Created by 박경선 on 18/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

import UIKit

extension String {
    func urlToImage() -> UIImage? {
        if let imageUrl = URL(string: self) {
            let imageData = try! Data(contentsOf: imageUrl)
            return UIImage(data: imageData)
        }
        return nil
    }
    
    func isValid(_ regex: String) -> Bool{
        let strTest = NSPredicate(format: "SELF MATCHES %@", regex)
        return strTest.evaluate(with: self)
    }
}

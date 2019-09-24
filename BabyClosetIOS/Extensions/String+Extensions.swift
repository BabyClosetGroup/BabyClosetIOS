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
    
    func hasCharacter(regex: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: regex, options: .caseInsensitive)
            if let _ = regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSMakeRange(0, self.count)) {
                return true
            }
        }  catch {
            print( error.localizedDescription)
            return false
        }
        return false
    }
}

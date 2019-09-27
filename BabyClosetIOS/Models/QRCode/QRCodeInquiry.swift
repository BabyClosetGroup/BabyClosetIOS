//
//  QRCodeInquiry.swift
//  BabyClosetIOS
//
//  Created by 최리안 on 27/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

import Foundation

struct QRCodeInquiry: Codable {
    let postIdx: Int?
    let postTitle: String?
    let qrcode: String?
    
    enum CodingKeys: String, CodingKey {
        case postIdx = "postIdx"
        case postTitle = "postTitle"
        case qrcode = "qrcode"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        postIdx = try values.decodeIfPresent(Int.self, forKey: .postIdx)
        postTitle = try values.decodeIfPresent(String.self, forKey: .postTitle)
        qrcode = try values.decodeIfPresent(String.self, forKey: .qrcode)
    }
}


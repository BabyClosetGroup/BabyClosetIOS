//
//  QRCodeList.swift
//  BabyClosetIOS
//
//  Created by 최리안 on 27/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

import Foundation

struct QRCodeList: Codable {
    let allPost: [allQRCodeList]?
    
    enum CodingKeys: String, CodingKey {
        case allPost = "allPost"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        allPost = try values.decodeIfPresent([allQRCodeList].self, forKey: .allPost)
    }
}

struct allQRCodeList: Codable {
    let postIdx: Int?
    let postTitle: String?
    let mainImage: String?
    let areaName: [String]?
    
    enum CodingKeys: String, CodingKey {
        case postIdx = "postIdx"
        case postTitle = "postTitle"
        case mainImage = "mainImage"
        case areaName = "areaName"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        postIdx = try values.decodeIfPresent(Int.self, forKey: .postIdx)
        postTitle = try values.decodeIfPresent(String.self, forKey: .postTitle)
        mainImage = try values.decodeIfPresent(String.self, forKey: .mainImage)
        areaName = try values.decodeIfPresent([String].self, forKey: .areaName)
    }
}

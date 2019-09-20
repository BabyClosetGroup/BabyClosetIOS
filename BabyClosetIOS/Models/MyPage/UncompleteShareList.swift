//
//  UncompleteShareList.swift
//  BabyClosetIOS
//
//  Created by 박경선 on 19/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

struct UncompleteShareList: Codable {
    let allPost: [UncompleteShare]?
    enum CodingKeys: String, CodingKey {
        case allPost = "allPost"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        allPost = try values.decodeIfPresent([UncompleteShare].self, forKey: .allPost)
    }
}

struct UncompleteShare: Codable {
    let postIdx: Int?
    let postTitle: String?
    let mainImage: String?
    let registerNumber: String?
    let areaName: [String]?
    
    enum CodingKeys: String, CodingKey {
        case postIdx = "postIdx"
        case postTitle = "postTitle"
        case mainImage = "mainImage"
        case registerNumber = "registerNumber"
        case areaName = "areaName"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        postIdx = try values.decodeIfPresent(Int.self, forKey: .postIdx)
        postTitle = try values.decodeIfPresent(String.self, forKey: .postTitle)
        mainImage = try values.decodeIfPresent(String.self, forKey: .mainImage)
        registerNumber = try values.decodeIfPresent(String.self, forKey: .registerNumber)
        areaName = try values.decodeIfPresent([String].self, forKey: .areaName)
    }
}

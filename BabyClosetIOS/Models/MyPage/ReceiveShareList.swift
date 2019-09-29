//
//  ReceiveShareList.swift
//  BabyClosetIOS
//
//  Created by 박경선 on 23/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

struct ReceiveShareList: Codable {
    let allPost: [ReceiveShare]?
    enum CodingKeys: String, CodingKey {
        case allPost = "allPost"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        allPost = try values.decodeIfPresent([ReceiveShare].self, forKey: .allPost)
    }
}

struct ReceiveShare: Codable {
    let postIdx: Int?
    let postName: String?
    let mainImage: String?
    
    let senderIdx: Int?
    let senderNickname: String?
    let sharedDate: String?
    let senderIsRated: Int?
    let rating: Float?
    let areaName: [String]?
    
    enum CodingKeys: String, CodingKey {
        case postIdx = "postIdx"
        case postName = "postName"
        case mainImage = "mainImage"
        case senderIdx = "senderIdx"
        case senderNickname = "senderNickname"
        case sharedDate = "sharedDate"
        case senderIsRated = "senderIsRated"
        case rating = "rating"
        case areaName = "areaName"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        postIdx = try values.decodeIfPresent(Int.self, forKey: .postIdx)
        postName = try values.decodeIfPresent(String.self, forKey: .postName)
        mainImage = try values.decodeIfPresent(String.self, forKey: .mainImage)
        senderIdx = try values.decodeIfPresent(Int.self, forKey: .senderIdx)
        senderNickname = try values.decodeIfPresent(String.self, forKey: .senderNickname)
        sharedDate = try values.decodeIfPresent(String.self, forKey: .sharedDate)
        senderIsRated = try values.decodeIfPresent(Int.self, forKey: .senderIsRated)
        rating = try values.decodeIfPresent(Float.self, forKey: .rating)
        areaName = try values.decodeIfPresent([String].self, forKey: .areaName)
    }
}

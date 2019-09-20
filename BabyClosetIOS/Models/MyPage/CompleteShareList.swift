//
//  CompleteShareList.swift
//  BabyClosetIOS
//
//  Created by 박경선 on 19/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

struct CompleteShareList: Codable {
    let allPost: [CompleteShare]?
    enum CodingKeys: String, CodingKey {
        case allPost = "allPost"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        allPost = try values.decodeIfPresent([CompleteShare].self, forKey: .allPost)
    }
}

struct CompleteShare: Codable {
    let postIdx: Int?
    let receiverIdx: Int?
    let receiverIsRated: Int?
    let postName: String?
    let mainImage: String?
    let receiverNickname : String?
    let sharedDate: String?
    let areaName: [String]?
    
    enum CodingKeys: String, CodingKey {
        case postIdx = "postIdx"
        case receiverIdx = "receiverIdx"
        case receiverIsRated = "receiverIsRated"
        case postName = "postName"
        case mainImage = "mainImage"
        case receiverNickname = "receiverNickname"
        case sharedDate = "sharedDate"
        case areaName = "areaName"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        postIdx = try values.decodeIfPresent(Int.self, forKey: .postIdx)
        receiverIdx = try values.decodeIfPresent(Int.self, forKey: .receiverIdx)
        receiverIsRated = try values.decodeIfPresent(Int.self, forKey: .receiverIsRated)
        postName = try values.decodeIfPresent(String.self, forKey: .postName)
        mainImage = try values.decodeIfPresent(String.self, forKey: .mainImage)
        receiverNickname = try values.decodeIfPresent(String.self, forKey: .receiverNickname)
        sharedDate = try values.decodeIfPresent(String.self, forKey: .sharedDate)
        areaName = try values.decodeIfPresent([String].self, forKey: .areaName)
    }
}

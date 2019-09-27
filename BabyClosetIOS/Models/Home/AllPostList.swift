//
//  AllPostList.swift
//  BabyClosetIOS
//
//  Created by 최리안 on 27/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

import Foundation

struct AllPostList: Codable {
    let isNewMessage: Int?
    let allPost: [allPostList]?
    
    enum CodingKeys: String, CodingKey {
        case isNewMessage = "isNewMessage"
        case allPost = "allPost"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        isNewMessage = try values.decodeIfPresent(Int.self, forKey: .isNewMessage)
        allPost = try values.decodeIfPresent([allPostList].self, forKey: .allPost)
    }
}

struct allPostList: Codable {
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

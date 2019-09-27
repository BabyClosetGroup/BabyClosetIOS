//
//  HomeList.swift
//  BabyClosetIOS
//
//  Created by 최리안 on 27/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

import Foundation

struct HomeList: Codable {
    let isNewMessage: Int?
    let deadlinePost: [deadlinePostList]?
    let recentPost: [recentPostList]?
    
    enum CodingKeys: String, CodingKey {
        case isNewMessage = "isNewMessage"
        case deadlinePost = "deadlinePost"
        case recentPost = "recentPost"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        isNewMessage = try values.decodeIfPresent(Int.self, forKey: .isNewMessage)
        deadlinePost = try values.decodeIfPresent([deadlinePostList].self, forKey: .deadlinePost)
        recentPost = try values.decodeIfPresent([recentPostList].self, forKey: .recentPost)
    }
}

struct deadlinePostList: Codable {
    let postIdx: Int?
    let postTitle: String?
    let deadline: String?
    let mainImage: String?
    let areaName: [String]?
    
    enum CodingKeys: String, CodingKey {
        case postIdx = "postIdx"
        case postTitle = "postTitle"
        case deadline = "deadline"
        case mainImage = "mainImage"
        case areaName = "areaName"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        postIdx = try values.decodeIfPresent(Int.self, forKey: .postIdx)
        postTitle = try values.decodeIfPresent(String.self, forKey: .postTitle)
        deadline = try values.decodeIfPresent(String.self, forKey: .deadline)
        mainImage = try values.decodeIfPresent(String.self, forKey: .mainImage)
        areaName = try values.decodeIfPresent([String].self, forKey: .areaName)
    }
}
struct recentPostList: Codable {
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

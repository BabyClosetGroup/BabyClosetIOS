//
//  DeadlinePostList.swift
//  BabyClosetIOS
//
//  Created by 최리안 on 27/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

import Foundation

struct DeadlinePostList: Codable {
    let isNewMessage: Int?
    let deadlinePost: [deadlinePostLists]?
    
    enum CodingKeys: String, CodingKey {
        case isNewMessage = "isNewMessage"
        case deadlinePost = "deadlinePost"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        isNewMessage = try values.decodeIfPresent(Int.self, forKey: .isNewMessage)
        deadlinePost = try values.decodeIfPresent([deadlinePostLists].self, forKey: .deadlinePost)
    }
}

struct deadlinePostLists: Codable {
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

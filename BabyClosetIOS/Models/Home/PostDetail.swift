//
//  PostDetail.swift
//  BabyClosetIOS
//
//  Created by 최리안 on 27/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

import Foundation

struct PostDetail: Codable {
    let isNewMessage: Int?
    let detailPost: detailPostContent?
    
    enum CodingKeys: String, CodingKey {
        case isNewMessage = "isNewMessage"
        case detailPost = "detailPost"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        isNewMessage = try values.decodeIfPresent(Int.self, forKey: .isNewMessage)
        detailPost = try values.decodeIfPresent(detailPostContent.self, forKey: .detailPost)
    }
}

struct detailPostContent: Codable {
    let postIdx: Int?
    let postTitle: String?
    let postContent: String?
    let deadline: String?
    let areaName: [String]?
    let ageName: [String]?
    let clothName: [String]?
    let nickname: String?
    let userIdx: Int?
    let profileImage: String?
    let rating: Float?
    let isSender: Int?
    let postImages: [String]?

    enum CodingKeys: String, CodingKey {
        case postIdx = "postIdx"
        case postTitle = "postTitle"
        case postContent = "postContent"
        case deadline = "deadline"
        case areaName = "areaName"
        case ageName = "ageName"
        case clothName = "clothName"
        case nickname = "nickname"
        case userIdx = "userIdx"
        case profileImage = "profileImage"
        case rating = "rating"
        case isSender = "isSender"
        case postImages = "postImages"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        postIdx = try values.decodeIfPresent(Int.self, forKey: .postIdx)
        postTitle = try values.decodeIfPresent(String.self, forKey: .postTitle)
        postContent = try values.decodeIfPresent(String.self, forKey: .postContent)
        deadline = try values.decodeIfPresent(String.self, forKey: .deadline)
        areaName = try values.decodeIfPresent([String].self, forKey: .areaName)
        ageName = try values.decodeIfPresent([String].self, forKey: .ageName)
        clothName = try values.decodeIfPresent([String].self, forKey: .clothName)
        nickname = try values.decodeIfPresent(String.self, forKey: .nickname)
        userIdx = try values.decodeIfPresent(Int.self, forKey: .userIdx)
        profileImage = try values.decodeIfPresent(String.self, forKey: .profileImage)
        rating = try values.decodeIfPresent(Float.self, forKey: .rating)
        isSender = try values.decodeIfPresent(Int.self, forKey: .isSender)
        postImages = try values.decodeIfPresent([String].self, forKey: .postImages)
    }
}

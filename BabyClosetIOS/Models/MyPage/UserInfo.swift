//
//  UserInfo.swift
//  BabyClosetIOS
//
//  Created by 박경선 on 18/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

struct UserInfo: Codable {
    let userIdx: Int?
    let userId: String?
    let username: String?
    let nickname: String?
    let profileImage: String?
    
    enum CodingKeys: String, CodingKey {
        case userIdx = "userIdx"
        case userId = "userId"
        case username = "username"
        case nickname = "nickname"
        case profileImage = "profileImage"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userIdx = try values.decodeIfPresent(Int.self, forKey: .userIdx)
        userId = try values.decodeIfPresent(String.self, forKey: .userId)
        username = try values.decodeIfPresent(String.self, forKey: .username)
        nickname = try values.decodeIfPresent(String.self, forKey: .nickname)
        profileImage = try values.decodeIfPresent(String.self, forKey: .profileImage)
    }
}

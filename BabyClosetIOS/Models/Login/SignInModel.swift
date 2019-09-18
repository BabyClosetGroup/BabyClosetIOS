//
//  SignInModel.swift
//  BabyClosetIOS
//
//  Created by 박경선 on 14/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

import Foundation

struct SignInModel: Codable {
    let userIdx: Int?
    let userId: String?
    let name: String?
    let nickname: String?
    let profileImage: String?
    let token: String?

    enum CodingKeys: String, CodingKey {
        case userIdx = "userIdx"
        case userId = "userId"
        case name = "name"
        case nickname = "nickname"
        case profileImage = "profileImage"
        case token = "token"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userIdx = try values.decodeIfPresent(Int.self, forKey: .userIdx)
        userId = try values.decodeIfPresent(String.self, forKey: .userId)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        nickname = try values.decodeIfPresent(String.self, forKey: .nickname)
        profileImage = try values.decodeIfPresent(String.self, forKey: .profileImage)
        token = try values.decodeIfPresent(String.self, forKey: .token)
    }
}

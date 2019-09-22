//
//  OtherDetailInfo.swift
//  BabyClosetIOS
//
//  Created by 박경선 on 22/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

struct OtherDetailInfo: Codable {
    let userIdx: Int?
    let nickname: String?
    let rating: Int?
    let profileImage: String?
    
    enum CodingKeys: String, CodingKey {
        case userIdx = "applicantIdx"
        case nickname = "applicantNickname"
        case rating = "rating"
        case profileImage = "profileImage"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userIdx = try values.decodeIfPresent(Int.self, forKey: .userIdx)
        nickname = try values.decodeIfPresent(String.self, forKey: .nickname)
        rating = try values.decodeIfPresent(Int.self, forKey: .rating)
        profileImage = try values.decodeIfPresent(String.self, forKey: .profileImage)
    }
}

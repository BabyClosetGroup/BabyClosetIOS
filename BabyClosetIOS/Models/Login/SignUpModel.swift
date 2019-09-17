////
////  SignUpModel.swift
////  BabyClosetIOS
////
////  Created by 박경선 on 14/09/2019.
////  Copyright © 2019 박경선. All rights reserved.
////
//
//import Foundation
//
//struct SignUpModel: Codable {
//    var userToken: String
//    var userIdx: Int
//    var userName: String
//    var timestamp: Float
//
////    "userId": "babycloset95",
////    "name": "황재석",
////    "nickname": "바나나킥",
////    "password": "abc123",
//
//    enum CodingKeys: String, CodingKey {
//        case userToken = "userToken"
//        case userIdx = "userIdx"
//        case userName = "userName"
//        case timestamp = "timestamp"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        userToken = try values.decodeIfPresent(String.self, forKey: .userToken)!
//        userIdx = try values.decodeIfPresent(Int.self, forKey: .userIdx)!
//        userName = try values.decodeIfPresent(String.self, forKey: .userName)!
//        timestamp = try values.decodeIfPresent(Float.self, forKey: .timestamp)!
//    }
//}

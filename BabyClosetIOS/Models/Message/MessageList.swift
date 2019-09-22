//
//  MessageList.swift
//  BabyClosetIOS
//
//  Created by 박경선 on 22/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//
struct MessageList: Codable {
    let messages: [Message]?
    enum CodingKeys: String, CodingKey {
        case messages = "messages"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        messages = try values.decodeIfPresent([Message].self, forKey: .messages)
    }
}

struct Message: Codable {
    var lastContent : String?
    var createdTime : String?
    var userIdx : Int?
    var nickname: String?
    var unreadCount : Int?
    
    enum CodingKeys: String, CodingKey {
        case userIdx = "userIdx"
        case lastContent = "lastContent"
        case createdTime = "createdTime"
        case nickname = "nickname"
        case unreadCount = "unreadCount"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userIdx = try values.decodeIfPresent(Int.self, forKey: .userIdx)
        lastContent = try values.decodeIfPresent(String.self, forKey: .lastContent)
        createdTime = try values.decodeIfPresent(String.self, forKey: .createdTime)
        nickname = try values.decodeIfPresent(String.self, forKey: .nickname)
        unreadCount = try values.decodeIfPresent(Int.self, forKey: .unreadCount)
    }
}

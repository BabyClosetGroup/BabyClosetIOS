//
//  MessageDetailModel.swift
//  BabyClosetIOS
//
//  Created by 박경선 on 03/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

import Foundation

struct MessageDetailModel : Codable {
    var receiver : MessageReceiver?
    var messages: [MessageDetailList]?
    
    enum CodingKeys: String, CodingKey {
        case receiver = "receiver"
        case messages = "messages"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        receiver = try values.decodeIfPresent(MessageReceiver.self, forKey: .receiver)
        messages = try values.decodeIfPresent([MessageDetailList].self, forKey: .messages)
    }
}
    
struct MessageReceiver : Codable {
    var userIdx : Int?
    var nickname: String?
    
    enum CodingKeys: String, CodingKey {
        case userIdx = "userIdx"
        case nickname = "nickname"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userIdx = try values.decodeIfPresent(Int.self, forKey: .userIdx)
        nickname = try values.decodeIfPresent(String.self, forKey: .nickname)
    }
}

struct MessageDetailList : Codable {
    var noteIdx : Int?
    var noteContent : String?
    var createdTime : String?
    var noteType: Int?
    
    enum CodingKeys: String, CodingKey {
        case noteIdx = "noteIdx"
        case noteContent = "noteContent"
        case createdTime = "createdTime"
        case noteType = "noteType"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        noteIdx = try values.decodeIfPresent(Int.self, forKey: .noteIdx)
        noteContent = try values.decodeIfPresent(String.self, forKey: .noteContent)
        createdTime = try values.decodeIfPresent(String.self, forKey: .createdTime)
        noteType = try values.decodeIfPresent(Int.self, forKey: .noteType)
    }
    
    init(content: String, created: String, title: Int){
        self.noteContent = content
        self.createdTime = created
        self.noteType = title
    }
}

//
//  MessageDetailModel.swift
//  BabyClosetIOS
//
//  Created by 박경선 on 03/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

import Foundation

struct MessageDetailModel : Codable {
    var idx : Int = 0
    var content : String
    var created : String
    var title: String
    
    enum CodingKeys: String, CodingKey {
        case idx = "noteIdx"
        case content = "noteContent"
        case created = "createdTime"
        case title = "noteType"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        idx = try values.decodeIfPresent(Int.self, forKey: .idx)!
        content = try values.decodeIfPresent(String.self, forKey: .content)!
        created = try values.decodeIfPresent(String.self, forKey: .created)!
        title = try values.decodeIfPresent(String.self, forKey: .title)!
    }
    
    init(content: String, created: String, title: String){
        self.content = content
        self.created = created
        self.title = title
    }
}

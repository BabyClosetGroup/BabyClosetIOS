//
//  FilteredAllPostList.swift
//  BabyClosetIOS
//
//  Created by 최리안 on 28/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

import Foundation

struct FilteredAllPostList: Codable {
    let isNewMessage: Int?
    let filteredAllPost: [allPostList]?
    
    enum CodingKeys: String, CodingKey {
        case isNewMessage = "isNewMessage"
        case filteredAllPost = "filteredAllPost"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        isNewMessage = try values.decodeIfPresent(Int.self, forKey: .isNewMessage)
        filteredAllPost = try values.decodeIfPresent([allPostList].self, forKey: .filteredAllPost)
    }
}


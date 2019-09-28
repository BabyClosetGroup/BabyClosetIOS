//
//  FilteredDeadlinePostList.swift
//  BabyClosetIOS
//
//  Created by 최리안 on 28/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

import Foundation

struct FilteredDeadlinePostList: Codable {
    let isNewMessage: Int?
    let filteredDeadlinePost: [deadlinePostLists]?
    
    enum CodingKeys: String, CodingKey {
        case isNewMessage = "isNewMessage"
        case filteredDeadlinePost = "filteredDeadlinePost"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        isNewMessage = try values.decodeIfPresent(Int.self, forKey: .isNewMessage)
        filteredDeadlinePost = try values.decodeIfPresent([deadlinePostLists].self, forKey: .filteredDeadlinePost)
    }
}

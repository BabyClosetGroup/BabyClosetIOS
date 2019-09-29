//
//  ImageModel.swift
//  BabyClosetIOS
//
//  Created by 박경선 on 18/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

struct ImageModel : Codable {
    let image : String?
    
    enum CodingKeys: String, CodingKey {
        case image = "message"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        image = try values.decodeIfPresent(String.self, forKey: .image)
    }
}

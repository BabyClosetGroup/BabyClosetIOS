//
//  ResponseArray.swift
//  BabyClosetIOS
//
//  Created by 박경선 on 19/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

struct ResponseArray<T: Codable>: Codable {
    let status: Int?
    let success: Bool?
    let message: String?
    let data: [T]?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case success = "success"
        case message = "message"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent( [T].self, forKey: .data)
    }
}

//
//  RequestShareList.swift
//  BabyClosetIOS
//
//  Created by 박경선 on 20/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

struct RequestShareList: Codable {
    let post: RequestPost?
    let applicants: [RequestShare]?
    enum CodingKeys: String, CodingKey {
        case post = "post"
        case applicants = "applicants"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        post = try values.decodeIfPresent(RequestPost.self, forKey: .post)
        applicants = try values.decodeIfPresent([RequestShare].self, forKey: .applicants)
    }
}

struct RequestPost: Codable {
    let postIdx: Int?
    let postTitle: String?
    let mainImage: String?
    let applicantNumber: String?
    let areaName: [String]?
    
    enum CodingKeys: String, CodingKey {
        case postIdx = "postIdx"
        case postTitle = "postTitle"
        case mainImage = "mainImage"
        case applicantNumber = "applicantNumber"
        case areaName = "areaName"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        postIdx = try values.decodeIfPresent(Int.self, forKey: .postIdx)
        postTitle = try values.decodeIfPresent(String.self, forKey: .postTitle)
        mainImage = try values.decodeIfPresent(String.self, forKey: .mainImage)
        applicantNumber = try values.decodeIfPresent(String.self, forKey: .applicantNumber)
        areaName = try values.decodeIfPresent([String].self, forKey: .areaName)
    }
}

struct RequestShare: Codable {
    let applicantIdx: Int?
    let applicantNickname: String?
    let rating: Float?
    let profileImage: String?
    
    enum CodingKeys: String, CodingKey {
        case applicantIdx = "applicantIdx"
        case applicantNickname = "applicantNickname"
        case rating = "rating"
        case profileImage = "profileImage"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        applicantIdx = try values.decodeIfPresent(Int.self, forKey: .applicantIdx)
        applicantNickname = try values.decodeIfPresent(String.self, forKey: .applicantNickname)
        rating = try values.decodeIfPresent(Float.self, forKey: .rating)
        profileImage = try values.decodeIfPresent(String.self, forKey: .profileImage)
    }
}

//
//  APIRouter.swift
//  BabyClosetIOS
//
//  Created by 박경선 on 14/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

import Alamofire

struct APIConfiguration {
    // 나중에 baseURL 꼭꼭 바꾸기
    static let baseURL = "http://15.164.112.80"

}

struct APIRouter {
    var url: String
    var method: HTTPMethod
    var parameters: Parameters?
    var headers: HTTPHeaders?
    var data: Data?
    
    init(url: String, method: HTTPMethod, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, data: Data? = nil) {
        self.url = url
        self.method = method
        self.parameters = parameters
        self.headers = headers
        self.data = data
    }
    
}
extension APIRouter {
    var requestUrl: String {
        return APIConfiguration.baseURL + url
    }
}

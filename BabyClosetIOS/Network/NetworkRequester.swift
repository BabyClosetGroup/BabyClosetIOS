//
//  NetworkRequester.swift
//  BabyClosetIOS
//
//  Created by 박경선 on 14/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum NetworkError: Error {
    case failure
}

struct NetworkRequester {
    
    private var api: APIRouter
    private let manager = Alamofire.SessionManager.default
    public typealias Completion1<T> = ((T?, Error?) -> Void)?
    public typealias Completion2<T> = ((T?,ErrorModel?, Error?) -> Void)?
    
    
    init(with router: APIRouter) {
        self.api = router
        manager.session.configuration.timeoutIntervalForRequest = 15
    }
    
    func signUpRequest<T: Codable>(completion: Completion1<T>) {
        manager.request(api.requestUrl, method: api.method, parameters: api.parameters, encoding: JSONEncoding.default, headers: api.headers)
            .validate(contentType: ["application/json"]).responseData { response in
                switch response.result {
                case .success:
                    if let resultStatusCode = response.response?.statusCode {
                        print("- NetworkRequester - Response statusCode : \(resultStatusCode)")
                        let data = response.data
                        var jsonString = JSON(data as Any).description
                        if jsonString ==  "null" {
                            jsonString = "{}"
                        }
                        let jsonData = jsonString.data(using: .utf8) ?? Data()
                        do {
                            let result = try JSONDecoder().decode(T.self, from: jsonData)
                            print("result. : ", result)
                            completion?(result, nil)
                        } catch let catchError{
                            print("캐치에러 \(catchError)")
                        }
                    }
                    
                case .failure(let failError):
                    //네트워크 자체가 안 될 경우
                    completion?(nil, failError)
                }
        }
    }
    
    func signInRequest<T: Codable>(completion: Completion2<T>) {
        manager.request(api.requestUrl, method: api.method, parameters: api.parameters, encoding: JSONEncoding.default, headers: api.headers)
            .validate(contentType: ["application/json"]).responseData { response in
                switch response.result {
                case .success:
                    if let resultStatusCode = response.response?.statusCode {
                        print("- NetworkRequester - Response statusCode : \(resultStatusCode)")
                        guard resultStatusCode < 300 else {
                            let data = response.data
                            let jsonString = JSON(data as Any).description
                            let jsonData = jsonString.data(using: .utf8) ?? Data()
                            do {
                                let result = try JSONDecoder().decode(ErrorModel.self, from: jsonData)
                                completion?(nil, result, nil)
                            } catch { }
                            return
                        }
                        let data = response.data
                        var jsonString = JSON(data as Any).description
                        if jsonString ==  "null" {
                            jsonString = "{}"
                        }
                        let jsonData = jsonString.data(using: .utf8) ?? Data()
                        do {
                            let result = try JSONDecoder().decode(T.self, from: jsonData)
                            completion?(result, nil, nil)
                        } catch let catchError{
                            print("캐치에러 \(catchError)")
                        }
                    }
                    
                case .failure(let failError):
                    completion?(nil,nil, failError)
                }
        }
    }
    
    func mypageRequest<T: Codable>(completion: Completion2<T>) {
        manager.request(api.requestUrl, method: api.method, parameters: api.parameters, encoding: JSONEncoding.default, headers: api.headers)
            .validate(contentType: ["multipart/form-data"]).responseData { response in
                switch response.result {
                case .success:
                    if let resultStatusCode = response.response?.statusCode {
                        print("- NetworkRequester - Response statusCode : \(resultStatusCode)")
                        let data = response.data
                        var jsonString = JSON(data as Any).description
                        if jsonString ==  "null" {
                            jsonString = "{}"
                        }
                        let jsonData = jsonString.data(using: .utf8) ?? Data()
                        do {
                            let result = try JSONDecoder().decode(T.self, from: jsonData)
                            completion?(result, nil, nil)
                        } catch let catchError{
                            print("캐치에러 \(catchError)")
                        }
                    }
                    
                case .failure(let failError):
                    completion?(nil,nil, failError)
                }
        }
    }
    
    
    func requestMultipartFormData<T: Codable>(completion: Completion1<T>) {
        let parameters : [String: String] = api.parameters as! [String : String]
        print(parameters)
        print(self.api.data!)
        manager.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(self.api.data!, withName: "profileImage", fileName: "image_name.jpeg", mimeType: "image/jpeg")
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
            }
        }, usingThreshold: UInt64.init(), to: api.requestUrl, method: api.method, headers: api.headers) { result in
            switch result {
            case .success(let upload, _, _):
                upload.responseData(completionHandler: { response in
                    if let resultStatusCode = response.response?.statusCode {
                        print("- NetworkRequester - Response statusCode : \(resultStatusCode)\n")
                        let data = response.data
                        var jsonString = JSON(data as Any).description
                        if jsonString ==  "null" {
                            jsonString = "{}"
                        }
                        let jsonData = jsonString.data(using: .utf8) ?? Data()
                        do {
                            let result = try JSONDecoder().decode(T.self, from: jsonData)
                            print("result : ", result)
                            completion?(result, nil)
                        } catch let catchError{
                            print("캐치에러 \(catchError)")
                        }
                    }
                })
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
            case .failure(let err):
                completion?(nil, err)
            }
        }
    }
    
    func requestMultipartFormDataList<T: Codable>(completion: Completion1<T>) {
        let parameters : [String: Any] = api.parameters as! [String : Any]
        print(parameters)
        manager.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                if key == "postImages" {
                    for img in value as! [Data] {
                        multipartFormData.append( img, withName: key, fileName: "image_name.jpeg", mimeType: "image/jpeg")
                    }
                } else {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
                }
            }
        }, usingThreshold: UInt64.init(), to: api.requestUrl, method: api.method, headers: api.headers) { result in
            switch result {
            case .success(let upload, _, _):
                upload.responseData(completionHandler: { response in
                    if let resultStatusCode = response.response?.statusCode {
                        print("- NetworkRequester - Response statusCode : \(resultStatusCode)\n")
                        let data = response.data
                        var jsonString = JSON(data as Any).description
                        if jsonString ==  "null" {
                            jsonString = "{}"
                        }
                        let jsonData = jsonString.data(using: .utf8) ?? Data()
                        do {
                            let result = try JSONDecoder().decode(T.self, from: jsonData)
                            print("result : ", result)
                            completion?(result, nil)
                        } catch let catchError{
                            print("캐치에러 \(catchError)")
                        }
                    }
                })
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
            case .failure(let err):
                completion?(nil, err)
            }
        }
    }
}

//
//  NetworkManager.swift
//  BabyClosetIOS
//
//  Created by 박경선 on 14/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkManager {
    let jwt = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWR4IjoyLCJuaWNrbmFtZSI6Iuq5gO2YleyyoOq1rO2VmCIsImlhdCI6MTU2ODIxOTA5OSwiZXhwIjoxNTc5MDE5MDk5LCJpc3MiOiJiYWJ5Q2xvc2V0In0.tmEh04olM1zm8oJId_QKdbw1_6cYvFDwfx0KV332PTk"
    //    let jwt = UserDefaults.standard.string(forKey: "token")
    
    func signup(userId:String, name:String, nickname:String, password:String, completion: @escaping (ErrorModel?,Error?) -> Void) {
        
        let parameters = [
            "userId": userId,
            "name": name,
            "nickname": nickname,
            "password": password
        ]
        
        // error model 과 success Model 이 동일
        let router = APIRouter(url:"/user/signup", method: .post, parameters: parameters)
        NetworkRequester(with: router).signUpRequest { ( result: ErrorModel?, error) in
            guard error == nil else {
                completion(nil,error)
                return
            }
            completion(result,error)
        }
    }
    
    func signin(userId: String, password: String, completion: @escaping ( ResponseBody<SignInModel>?, ErrorModel?, Error?) -> Void) {
        
        let parameters = [
            "userId": userId,
            "password": password
        ]
        
        let router = APIRouter(url:"/user/signin", method: .post, parameters: parameters)
        NetworkRequester(with: router).signInRequest { (login: ResponseBody<SignInModel>?, errorModel: ErrorModel? , error)  in
            guard error == nil else {
                completion(nil, nil,error)
                return
            }
            completion(login, errorModel, error)
        }
    }
    
    
    func getUserInfo( completion: @escaping ( ResponseBody<UserInfo>?, ErrorModel?, Error?) -> Void) {
        let header : HTTPHeaders = [
            "token": jwt
        ]
        let router = APIRouter(url: "/user", method: .get, parameters: nil, headers: header)
        NetworkRequester(with: router).signInRequest { (userModel: ResponseBody<UserInfo>?, errorModel: ErrorModel? , error)  in
            guard error == nil else {
                completion(nil, nil,error)
                return
            }
            completion(userModel, errorModel, error)
        }
    }
    
    func getUncompleteShare( completion: @escaping ( ResponseBody<UncompleteShareList>?, ErrorModel?, Error?) -> Void) {
        let header : HTTPHeaders = [
            "token": jwt
        ]
        
        let router = APIRouter(url: "/share/uncompleted", method: .get, parameters: nil, headers: header)
        NetworkRequester(with: router).signInRequest { (res: ResponseBody<UncompleteShareList>?, errorModel: ErrorModel? , error)  in
            guard error == nil else {
                completion(nil, nil,error)
                return
            }
            completion(res, errorModel, error)
        }
    }
    
    
    func getCompleteShare( completion: @escaping ( ResponseBody<CompleteShareList>?, ErrorModel?, Error?) -> Void) {
        let header : HTTPHeaders = [
            "token": jwt
        ]
        
        let router = APIRouter(url: "/share/completed", method: .get, parameters: nil, headers: header)
        NetworkRequester(with: router).signInRequest { (res: ResponseBody<CompleteShareList>?, errorModel: ErrorModel? , error)  in
            guard error == nil else {
                completion(nil, nil,error)
                return
            }
            completion(res, errorModel, error)
        }
    }
    
    func getRequestShareList(postIdx: Int, completion: @escaping ( ResponseBody<RequestShareList>?, ErrorModel?, Error?) -> Void) {
        let header:HTTPHeaders = [
            "token": jwt
        ]
        let router = APIRouter(url: "/share/\(postIdx)", method: .get, parameters: nil, headers: header)
        NetworkRequester(with: router).signInRequest { (list: ResponseBody<RequestShareList>?, errorModel: ErrorModel? , error)  in
            guard error == nil else {
                completion(nil, nil,error)
                return
            }
            completion(list, errorModel, error)
        }
    }
    
    func setUserInfo(nickname: String, password: String, image: Data, completion: @escaping ( ResponseBody<UserInfo>?, ErrorModel?, Error?) -> Void) {
        let header:HTTPHeaders = [
            "token": jwt
        ]
        let parameters: [String:String] = [
            "nickname": nickname,
            "password": password
        ]

        let router = APIRouter(url: "/user", method: .put, parameters: parameters, headers: header, data: image)
        NetworkRequester(with: router).requestMultipartFormData{ (Img: ResponseBody<UserInfo>?, errorModel :ErrorModel? , error) in
            guard error == nil else {
                completion(nil,errorModel,error)
                return
            }
            completion(Img,errorModel,error)
        }
    }
}

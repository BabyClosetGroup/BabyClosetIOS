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

struct APIConstants {
    static let signUpURL = "/user/signup"
    static let signInURL = "/user/signin"
}

class NetworkManager {
    
//    let jwt = UserDefaults.standard.string(forKey: "jwt")
    
    let jwt = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWR4IjoyLCJuaWNrbmFtZSI6Iuq5gO2YleyyoOq1rO2VmCIsImlhdCI6MTU2ODIxOTA5OSwiZXhwIjoxNTc5MDE5MDk5LCJpc3MiOiJiYWJ5Q2xvc2V0In0.tmEh04olM1zm8oJId_QKdbw1_6cYvFDwfx0KV332PTk"
    
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
    
    func signin(userId: String, password: String, completion: @escaping ( ResponseArray<SignInModel>?, ErrorModel?, Error?) -> Void) {
        
        let parameters = [
            "userId": userId,
            "password": password
        ]
        
        let router = APIRouter(url:"/user/signin", method: .post, parameters: parameters)
        NetworkRequester(with: router).signInRequest { (login: ResponseArray<SignInModel>?, errorModel: ErrorModel? , error)  in
            guard error == nil else {
                completion(nil, nil,error)
                return
            }
            completion(login, errorModel, error)
        }
    }
    
}

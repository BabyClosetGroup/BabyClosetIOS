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
    func signup(userId: String, name: String, nickname: String, password: String, completion: @escaping (ErrorModel?,Error?) -> Void) {
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
    
    func saveRating(userIdx: Int, rating: Int, postIdx: Int, completion: @escaping ( ErrorModel?, Error?) -> Void) {
        let header : HTTPHeaders = [
            "token": jwt
        ]
        let parameters = [
            "userIdx": userIdx,
            "rating": rating,
            "postIdx": postIdx
        ]
        
        let router = APIRouter(url:"/rating", method: .post, parameters: parameters, headers: header)
        NetworkRequester(with: router).signUpRequest { (result: ErrorModel?, error)  in
            guard error == nil else {
                completion(nil, error)
                return
            }
            completion(result, error)
        }
    }
    
    
    func getUserInfo( completion: @escaping ( ResponseBody<UserInfo>?, Error?) -> Void) {
        let header : HTTPHeaders = [
            "token": jwt
        ]
        let router = APIRouter(url: "/user", method: .get, parameters: nil, headers: header)
        NetworkRequester(with: router).signUpRequest { ( result: ResponseBody<UserInfo>?, error) in
            guard error == nil else {
                completion(nil,error)
                return
            }
            completion(result,error)
        }
    }
    
    func getReceivedShare( completion: @escaping ( ResponseBody<ReceiveShareList>?, Error?) -> Void) {
        let header : HTTPHeaders = [
            "token": jwt
        ]
        
        let router = APIRouter(url: "/share/received", method: .get, parameters: nil, headers: header)
        NetworkRequester(with: router).signUpRequest { ( result: ResponseBody<ReceiveShareList>?, error) in
            guard error == nil else {
                completion(nil,error)
                return
            }
            completion(result,error)
        }
    }
    
    func getUncompleteShare( completion: @escaping ( ResponseBody<UncompleteShareList>?, Error?) -> Void) {
        let header : HTTPHeaders = [
            "token": jwt
        ]
        
        let router = APIRouter(url: "/share/uncompleted", method: .get, parameters: nil, headers: header)
        NetworkRequester(with: router).signUpRequest { ( result: ResponseBody<UncompleteShareList>?, error) in
            guard error == nil else {
                completion(nil,error)
                return
            }
            completion(result,error)
        }
    }
    
    
    func getCompleteShare( completion: @escaping ( ResponseBody<CompleteShareList>?, Error?) -> Void) {
        let header : HTTPHeaders = [
            "token": jwt
        ]
        
        let router = APIRouter(url: "/share/completed", method: .get, parameters: nil, headers: header)
        NetworkRequester(with: router).signUpRequest { ( result: ResponseBody<CompleteShareList>?, error) in
            guard error == nil else {
                completion(nil,error)
                return
            }
            completion(result,error)
        }
    }
    
    func getRequestShareList(postIdx: Int, completion: @escaping ( ResponseBody<RequestShareList>?, Error?) -> Void) {
        let header:HTTPHeaders = [
            "token": jwt
        ]
        let router = APIRouter(url: "/share/\(postIdx)", method: .get, parameters: nil, headers: header)
        NetworkRequester(with: router).signUpRequest { ( result: ResponseBody<RequestShareList>?, error) in
            guard error == nil else {
                completion(nil,error)
                return
            }
            completion(result,error)
        }
    }
    
    func setUserInfo(nickname: String, password: String, image: Data, completion: @escaping ( ResponseBody<UserInfo>?, Error?) -> Void) {
        let header:HTTPHeaders = [
            "token": jwt
        ]
        let parameters: [String:String] = [
            "nickname": nickname,
            "password": password
        ]
        let router = APIRouter(url: "/user", method: .put, parameters: parameters, headers: header, data: image)
        NetworkRequester(with: router).requestMultipartFormData{ (Img: ResponseBody<UserInfo>?, error) in
            guard error == nil else {
                completion(nil,error)
                return
            }
            completion(Img, error)
        }
    }
    
    func getMessageList(completion: @escaping ( ResponseBody<MessageList>?, Error?) -> Void) {
        let header:HTTPHeaders = [
            "token": jwt
        ]
        
        let router = APIRouter(url: "/note", method: .get, parameters: nil, headers: header)
        NetworkRequester(with: router).signUpRequest{ (result: ResponseBody<MessageList>?, error) in
            guard error == nil else {
                completion(nil, error)
                return
            }
            completion(result,error)
        }
    }
    
    func getOtherUserInfo(userIdx: Int, completion: @escaping ( ResponseBody<OtherDetailInfo>?, Error?) -> Void) {
        let header:HTTPHeaders = [
            "token": jwt
        ]
        let router = APIRouter(url: "/rating/\(userIdx)", method: .get, parameters: nil, headers: header)
        NetworkRequester(with: router).signUpRequest{ (result: ResponseBody<OtherDetailInfo>?, error) in
            guard error == nil else {
                completion(nil, error)
                return
            }
            completion(result,error)
        }
    }
    
    func getDetailMessageList(userIdx: Int, completion: @escaping ( ResponseBody<MessageDetailModel>?, Error?) -> Void) {
        let header:HTTPHeaders = [
            "token": jwt
        ]
        
        let router = APIRouter(url: "/note/\(userIdx)", method: .get, parameters: nil, headers: header)
        NetworkRequester(with: router).signUpRequest{ (result: ResponseBody<MessageDetailModel>?, error) in
            guard error == nil else {
                completion(nil, error)
                return
            }
            completion(result,error)
        }
    }
    
    func posting( title: String, content: String, deadline: String, areaCategory: String, ageCategory: String, clothCategory: String, images: [Data], completion: @escaping ( ErrorModel?, Error?) -> Void) {
        let header:HTTPHeaders = [
            "token": jwt
        ]
        let parameters: [String:Any] = [
            "title": title,
            "content": content,
            "deadline": deadline,
            "areaCategory": areaCategory,
            "ageCategory": ageCategory,
            "clothCategory": clothCategory,
            "postImages": images,
        ]
        
        let router = APIRouter(url: "/post", method: .post, parameters: parameters, headers: header)
        NetworkRequester(with: router).requestMultipartFormDataList { (Img: ErrorModel?, error) in
            guard error == nil else {
                completion(nil,error)
                return
            }
            completion(Img, error)
        }
    }
    
    //Home
    func getHomeList(completion: @escaping ( ResponseBody<HomeList>?, Error?) -> Void) {
        let header:HTTPHeaders = [
            "token": jwt
        ]
        let router = APIRouter(url: "/post/main", method: .get, parameters: nil, headers: header)
        NetworkRequester(with: router).signUpRequest{ (result: ResponseBody<HomeList>?, error) in
            guard error == nil else {
                completion(nil, error)
                return
            }
            completion(result,error)
        }
    }
    
    func getAllList(completion: @escaping ( ResponseBody<AllPostList>?, Error?) -> Void) {
        let header:HTTPHeaders = [
            "token": jwt
        ]
        let router = APIRouter(url: "/post/all/1", method: .get, parameters: nil, headers: header)
        NetworkRequester(with: router).signUpRequest{ (result: ResponseBody<AllPostList>?, error) in
            guard error == nil else {
                completion(nil, error)
                return
            }
            completion(result,error)
        }
    }
    
    func getDeadLineList(completion: @escaping ( ResponseBody<DeadlinePostList>?, Error?) -> Void) {
        let header:HTTPHeaders = [
            "token": jwt
        ]
        let router = APIRouter(url: "/post/deadline/1", method: .get, parameters: nil, headers: header)
        NetworkRequester(with: router).signUpRequest{ (result: ResponseBody<DeadlinePostList>?, error) in
            guard error == nil else {
                completion(nil, error)
                return
            }
            completion(result,error)
        }
    }
    
    func getPostDetail(postIdx: Int, completion: @escaping ( ResponseBody<PostDetail>?, Error?) -> Void) {
        let header:HTTPHeaders = [
            "token": jwt
        ]
        
        let router = APIRouter(url: "/post/\(postIdx)", method: .get, parameters: nil, headers: header)
        NetworkRequester(with: router).signUpRequest{ (result: ResponseBody<PostDetail>?, error) in
            guard error == nil else {
                completion(nil, error)
                return
            }
            completion(result,error)
        }
    }
    
    
    
//    func getQRCodeList(completion: @escaping ( ResponseBody<QRCodeList>?, Error?) -> Void) {
//        let header:HTTPHeaders = [
//            "token": jwt
//        ]
//
//        let router = APIRouter(url: "/post/qrcode", method: .get, parameters: nil, headers: header)
//        NetworkRequester(with: router).signUpRequest{ (result: ResponseBody<QRCodeList>?, error) in
//            guard error == nil else {
//                completion(nil, error)
//                return
//            }
//            completion(result,error)
//        }
//    }
//    func getQRCode(userIdx: Int, completion: @escaping ( ResponseBody<QRCodeInquiry>?, Error?) -> Void) {
//    }
//    func authQRCode(query: String, completion: @escaping ( ResponseBody<MessageDetailModel>?, Error?) -> Void) {
//    }
    
    
    
    
    
//    func searchList(query: String, completion: @escaping ( ResponseBody<AllPostList>?, Error?) -> Void) {
//        let header:HTTPHeaders = [
//            "token": jwt
//        ]
//        let parameters: [String:Any] = [
//            "query": query,
//        ]
//
//        let router = APIRouter(url: "/post/search", method: .post, parameters: parameters, headers: header)
//        NetworkRequester(with: router).signUpRequest{ (result: ResponseBody<AllPostList>?, error) in
//            guard error == nil else {
//                completion(nil, error)
//                return
//            }
//            completion(result,error)
//        }
//    }
    
}

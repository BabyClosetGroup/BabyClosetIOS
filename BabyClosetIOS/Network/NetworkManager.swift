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
    let jwt = UserDefaults.standard.string(forKey: "token")!
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
    
    func signin(userId: String, password: String, completion: @escaping ( ResponseBody<SignInModel>?, Error?) -> Void) {
        
        let parameters = [
            "userId": userId,
            "password": password
        ]
        
        let router = APIRouter(url:"/user/signin", method: .post, parameters: parameters)
        NetworkRequester(with: router).signUpRequest { (login: ResponseBody<SignInModel>?, error)  in
            guard error == nil else {
                completion(nil,error)
                return
            }
            completion(login, error)
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
        
        print("userIdx   : ", userIdx)
        let router = APIRouter(url: "/rating/IOS/\(userIdx)", method: .get, parameters: nil, headers: header)
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
    
    func sendMessage( receiverIdx: Int, noteContent: String, completion: @escaping ( ErrorModel?, Error?) -> Void) {
        let header:HTTPHeaders = [
            "token": jwt
        ]
        let parameters: [String:Any] = [
            "receiverIdx": receiverIdx,
            "noteContent": noteContent,
        ]
        
        let router = APIRouter(url: "/note", method: .post, parameters: parameters, headers: header)
        NetworkRequester(with: router).signUpRequest { (Img: ErrorModel?, error) in
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
    
    func getAllList(page: Int, completion: @escaping ( ResponseBody<AllPostList>?, Error?) -> Void) {
        let header:HTTPHeaders = [
            "token": jwt
        ]
        let router = APIRouter(url: "/post/all/\(page)", method: .get, parameters: nil, headers: header)
        NetworkRequester(with: router).signUpRequest{ (result: ResponseBody<AllPostList>?, error) in
            guard error == nil else {
                completion(nil, error)
                return
            }
            completion(result,error)
        }
    }
    
    func getDeadLineList(page: Int, completion: @escaping ( ResponseBody<DeadlinePostList>?, Error?) -> Void) {
        let header:HTTPHeaders = [
            "token": jwt
        ]
        let router = APIRouter(url: "/post/deadline/\(page)", method: .get, parameters: nil, headers: header)
        NetworkRequester(with: router).signUpRequest{ (result: ResponseBody<DeadlinePostList>?, error) in
            guard error == nil else {
                completion(nil, error)
                return
            }
            completion(result,error)
        }
    }
    
    func getFilteredAllList(page: Int, area: String, age: String, cloth: String, completion: @escaping ( ResponseBody<FilteredAllPostList>?, Error?) -> Void) {
        let header:HTTPHeaders = [
            "token": jwt
        ]
        let parameters: [String:Any] = [
            "area": area,
            "age": age,
            "cloth": cloth,
        ]
        let router = APIRouter(url: "/post/filter/all/\(page)", method: .post, parameters: parameters, headers: header)
        NetworkRequester(with: router).signUpRequest{ (result: ResponseBody<FilteredAllPostList>?, error) in
            guard error == nil else {
                completion(nil, error)
                return
            }
            completion(result,error)
        }
    }
    
    func getFilteredDeadLineList(page: Int, area: String, age: String, cloth: String, completion: @escaping ( ResponseBody<FilteredDeadlinePostList>?, Error?) -> Void) {
        let header:HTTPHeaders = [
            "token": jwt
        ]
        let parameters: [String:Any] = [
            "area": area,
            "age": age,
            "cloth": cloth,
        ]
        let router = APIRouter(url: "/post/filter/deadline/\(page)", method: .post, parameters: parameters, headers: header)
        NetworkRequester(with: router).signUpRequest{ (result: ResponseBody<FilteredDeadlinePostList>?, error) in
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
    
    func share (postIdx: Int, completion: @escaping (ErrorModel?,Error?) -> Void) {
        let header:HTTPHeaders = [
            "token": jwt
        ]
        
        let parameters = [
            "postIdx": postIdx,
        ]
        
        let router = APIRouter(url:"/share", method: .post, parameters: parameters, headers: header)
        NetworkRequester(with: router).signUpRequest { ( result: ErrorModel?, error) in
            guard error == nil else {
                completion(nil,error)
                return
            }
            completion(result,error)
        }
    }
    
    
    
    // QRCode
    func getQRCodeList(completion: @escaping ( ResponseBody<QRCodeList>?, Error?) -> Void) {
        let header:HTTPHeaders = [
            "token": jwt
        ]

        let router = APIRouter(url: "/post/qrcode", method: .get, parameters: nil, headers: header)
        NetworkRequester(with: router).signUpRequest{ (result: ResponseBody<QRCodeList>?, error) in
            guard error == nil else {
                completion(nil, error)
                return
            }
            completion(result,error)
        }
    }
    func getQRCode(postIdx: Int, completion: @escaping ( ResponseBody<QRCodeInquiry>?, Error?) -> Void) {
        let header:HTTPHeaders = [
            "token": jwt
        ]
        
        let router = APIRouter(url: "/qrcode/\(postIdx)", method: .get, parameters: nil, headers: header)
        NetworkRequester(with: router).signUpRequest{ (result: ResponseBody<QRCodeInquiry>?, error) in
            guard error == nil else {
                completion(nil, error)
                return
            }
            completion(result,error)
        }
    }
    func authQRCode (decode: String, completion: @escaping (ErrorModel?,Error?) -> Void) {
        let header:HTTPHeaders = [
            "token": jwt
        ]
        
        let parameters = [
            "decode": decode,
        ]
        
        let router = APIRouter(url:"/qrcode", method: .post, parameters: parameters, headers: header)
        NetworkRequester(with: router).signUpRequest { ( result: ErrorModel?, error) in
            guard error == nil else {
                completion(nil,error)
                return
            }
            completion(result,error)
        }
    }

    
    //Detail
    func postModify( postIdx: Int, title: String, content: String, deadline: String, areaCategory: String, ageCategory: String, clothCategory: String, images: [Data], completion: @escaping ( ErrorModel?, Error?) -> Void) {
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
        
        let router = APIRouter(url: "/post/\(postIdx)", method: .put, parameters: parameters, headers: header)
        NetworkRequester(with: router).requestMultipartFormDataList { (Img: ErrorModel?, error) in
            guard error == nil else {
                completion(nil,error)
                return
            }
            completion(Img, error)
        }
    }
    
    //alert
    func deletePost(postIdx: Int, completion: @escaping ( ErrorModel?, Error?) -> Void) {
        let header:HTTPHeaders = [
            "token": jwt
        ]
        
        let router = APIRouter(url: "/post/\(postIdx)", method: .delete, parameters: nil, headers: header)
        NetworkRequester(with: router).signUpRequest{ (result: ErrorModel?, error) in
            guard error == nil else {
                completion(nil, error)
                return
            }
            completion(result,error)
        }
    }
    func report(postIdx: Int, complainReason: String, completion: @escaping (ErrorModel?,Error?) -> Void) {
        let header:HTTPHeaders = [
            "token": jwt
        ]
        
        let parameters: [String:Any]  = [
            "postIdx": postIdx,
            "complainReason": complainReason,
        ]
        
        let router = APIRouter(url:"/complain", method: .post, parameters: parameters, headers: header)
        NetworkRequester(with: router).signUpRequest { ( result: ErrorModel?, error) in
            guard error == nil else {
                completion(nil,error)
                return
            }
            completion(result,error)
        }
    }
    
    
    
    
    
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

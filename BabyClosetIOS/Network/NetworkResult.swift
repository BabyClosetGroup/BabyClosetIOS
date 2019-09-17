//
//  NetworkResult.swift
//  BabyClosetIOS
//
//  Created by 박경선 on 16/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}

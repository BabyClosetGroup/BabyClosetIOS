////
////  SignUpSecondVC.swift
////  BabyClosetIOS
////
////  Created by 박경선 on 17/09/2019.
////  Copyright © 2019 박경선. All rights reserved.
////
//
//import UIKit
//
//class SignUpSecondVC: UIViewController, UITextFieldDelegate {
//
//
//    var name: String = ""
//    var id: String = ""
//    var passwd: String = ""
//    let networkManager = NetworkManager()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        nicknameTextField.delegate = self
//        nicknameContainerView.roundCorners(corners: [.allCorners], radius: 8)
//        nicknameTextField.font = UIFont(name: "SeoulNamsanL", size: 12)
//    }
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.view.endEditing(true)
//    }
//
//    @IBAction func completeAction(_ sender: Any) {
//        if !gsno(nicknameTextField.text).isValid("^(?=[가-힣ㄱ-ㅎㅏ-ㅣ]).{1,8}") {
//            self.simpleAlert(title: "닉네임을 조건에 맞게 다시 입력해주세요.", message: "")
//        } else {
//
//
//        }
//    }
//}

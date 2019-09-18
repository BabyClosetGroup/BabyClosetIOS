//
//  LoginVC.swift
//  BabyClosetIOS
//
//  Created by 박경선 on 01/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

import UIKit

class LoginVC: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var idContainerView: UIView!
    @IBOutlet weak var passwdContainerView: UIView!
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwdTextField: UITextField!
    
    let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        idTextField.delegate = self
        passwdTextField.delegate = self
        idContainerView.roundCorners(corners: [.allCorners], radius: 8)
        passwdContainerView.roundCorners(corners: [.allCorners], radius: 8)
        idTextField.font = UIFont(name: "SeoulNamsanL", size: 12)
        passwdTextField.font = UIFont(name: "SeoulNamsanL", size: 12)
    }
    
    @IBAction func loginAction(_ sender: Any) {
        // 대충 로그인 체크되는 기능
        networkManager.signin(userId: gsno(idTextField.text), password: gsno(passwdTextField.text) ){ [weak self] (success, fail, error) in
            if success == nil && fail == nil && error != nil {
                self?.simpleAlert(title: "", message: "네트워크 오류입니다.")
            }
            else if success == nil && fail != nil && error == nil {
                if let msg = fail?.message {
                    self?.simpleAlert(title: "", message: msg)
                }
            } else if success != nil && fail == nil && error == nil {
                print("success : ", success)
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let dvc = storyboard.instantiateViewController(withIdentifier: "MainView")
                self?.present(dvc, animated: true, completion: nil)
            } else {
                print("엥")
            }
        }
    }
}

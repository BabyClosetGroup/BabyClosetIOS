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
        print("login master")
    }

}

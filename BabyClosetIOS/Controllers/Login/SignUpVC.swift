//
//  SignUpVC.swift
//  BabyClosetIOS
//
//  Created by 박경선 on 01/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var nameContainerView: UIView!
    @IBOutlet weak var idContainerView: UIView!
    @IBOutlet weak var pwContainerView: UIView!
    @IBOutlet weak var pwCheckContainerView: UIView!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwdTextField: UITextField!
    @IBOutlet weak var passwdCheckTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
        idTextField.delegate = self
        passwdTextField.delegate = self
        passwdCheckTextField.delegate = self
        
        nameContainerView.roundCorners(corners: [.allCorners], radius: 8)
        idContainerView.roundCorners(corners: [.allCorners], radius: 8)
        pwContainerView.roundCorners(corners: [.allCorners], radius: 8)
        pwCheckContainerView.roundCorners(corners: [.allCorners], radius: 8)
        
        nameTextField.font = UIFont(name: "SeoulNamsanL", size: 12)
        idTextField.font = UIFont(name: "SeoulNamsanL", size: 12)
        passwdTextField.font = UIFont(name: "SeoulNamsanL", size: 12)
        passwdCheckTextField.font = UIFont(name: "SeoulNamsanL", size: 12)
    }
    
}

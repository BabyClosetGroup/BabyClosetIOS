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
    @IBOutlet weak var nicknameContainerView: UIView!
    
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwdTextField: UITextField!
    @IBOutlet weak var passwdCheckTextField: UITextField!
    
    var keyboardShown: Bool = true
    var activeTextField = UITextField()
    var isEdit: Bool = false
    let networkManager = NetworkManager()
    var originY: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        originY = self.view.frame.origin.y
        nicknameContainerView.roundCorners(corners: [.allCorners], radius: 8)
        nameContainerView.roundCorners(corners: [.allCorners], radius: 8)
        idContainerView.roundCorners(corners: [.allCorners], radius: 8)
        pwContainerView.roundCorners(corners: [.allCorners], radius: 8)
        pwCheckContainerView.roundCorners(corners: [.allCorners], radius: 8)
        
        setInitialTextField(nameTextField)
        setInitialTextField(idTextField)
        setInitialTextField(passwdTextField)
        setInitialTextField(passwdCheckTextField)
        setInitialTextField(nicknameTextField)
    }
    
    func setInitialTextField(_ textField: UITextField){
        textField.delegate = self
        textField.font = UIFont(name: "SeoulNamsanL", size: 12)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unregisterForKeyboardNotifications()
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        self.activeTextField = textField
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        if activeTextField != nameTextField &&
            activeTextField != idTextField &&
            keyboardShown &&
            self.view.frame.origin.y == originY {
            self.view.frame.origin.y -= 180
            isEdit = true
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        self.view.frame.origin.y = originY
        if( isEdit ){
            self.view.frame.origin.y = originY
            isEdit = false
        }
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func goNextAction(_ sender: Any) {
        if nameTextField.text == "" || idTextField.text == "" || passwdTextField.text == "" || passwdCheckTextField.text == ""{
            self.simpleAlert(title: "정보를 입력해 주세요!", message: "")
        } else if !gsno(nameTextField.text).hasCharacter(regex: "^[A-Z가-힣a-z]{1,}$") {
            self.simpleAlert(title: "이름을 조건에 맞게 다시 입력해주세요.", message: "")
        } else if !gsno(idTextField.text).hasCharacter(regex: "^[A-Z0-9a-z]{1,}$"){
            self.simpleAlert(title: "아이디를 조건에 맞게 다시 입력해주세요.", message: "")
        } else if !gsno(passwdTextField.text).hasCharacter(regex: "^[a-zA-Z0-9]{6,}$") {
            self.simpleAlert(title: "비밀번호를 조건에 맞게 다시 입력해주세요.", message: "")
        } else if passwdTextField.text != passwdCheckTextField.text {
            self.simpleAlert(title: "비밀번호가 맞지 않습니다.", message: "")
        } else if !gsno(nicknameTextField.text).hasCharacter(regex: "^[가-힣]{1,8}$") {
            self.simpleAlert(title: "", message: "닉네임을 형식에 맞게 입력해주세요.")
        }
            
        else {
            networkManager.signup(userId: gsno(idTextField.text), name: gsno(nameTextField.text), nickname: gsno(nicknameTextField.text), password: gsno(passwdTextField.text)){ [weak self] (result, error) in
                if result == nil && error != nil {
                    self?.simpleAlert(title: "", message: "네트워크 오류입니다.")
                }
                else if result != nil && error == nil {
                    guard let status = result?.status, status < 300 else {
                        if let msg = result?.message {
                            self?.simpleAlert(title: "", message: msg)
                        }
                        return
                    }
                    let vc = self?.storyboard?.instantiateViewController(withIdentifier: "SignUpEndVC") as! SignUpEndVC
                    vc.nickname = (self?.nicknameTextField.text)!
                    self?.present(vc, animated: true, completion: nil)
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

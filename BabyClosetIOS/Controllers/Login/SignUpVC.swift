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
    
    var keyboardShown: Bool = false
    var isEdit: Bool = false
    let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        setInitialTextField(nameTextField)
        setInitialTextField(idTextField)
        setInitialTextField(passwdTextField)
        setInitialTextField(passwdCheckTextField)
    }
    
    func setInitialTextField(_ textField: UITextField){
        textField.delegate = self
        textField.roundCorners(corners: [.allCorners], radius: 8)
        textField.font = UIFont(name: "SeoulNamsanL", size: 12)
    }
    
    @IBAction func goNextAction(_ sender: Any) {
        if nameTextField.text == "" || idTextField.text == "" || passwdTextField.text == "" || passwdCheckTextField.text == ""{
            self.simpleAlert(title: "정보를 입력해 주세요!", message: "")
        } else if !isValid(nameTextField.text!, "(?=[A-Za-z가-힣\\D]).{3,}") {
            self.simpleAlert(title: "이름을 조건에 맞게 다시 입력해주세요.", message: "")
        } else if !isValid(idTextField.text!, "(?=[A-Z0-9a-z]).{3,}") {
            self.simpleAlert(title: "아이디를 조건에 맞게 다시 입력해주세요.", message: "")
        } else if !isValid(passwdTextField.text!, "(?=.*[a-zA-Z])(?=.*[0-9]).{6,}") {
            self.simpleAlert(title: "비밀번호를 조건에 맞게 다시 입력해주세요.", message: "")
        } else if passwdTextField.text != passwdCheckTextField.text {
            self.simpleAlert(title: "비밀번호가 맞지 않습니다.", message: "")
        } else {
            networkManager.signup(userId: gsno(idTextField.text), name: gsno(nameTextField.text), nickname: "hiImNick", password: gsno(passwdTextField.text)){ [weak self](signin, errorModel, error) in
                // 로그인 네트워크 처리
                if signin == nil && errorModel == nil && error != nil {
                    print("11111111")
                }
                else if signin == nil && errorModel != nil && error == nil {
                    print("22222222")
                }
                else {
                    print("33333333")
                }
            }
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpTermsVC") as! SignUpTermsVC
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func isValid(_ str: String, _ regex: String) -> Bool{
        let strTest = NSPredicate(format: "SELF MATCHES %@", regex)
        return strTest.evaluate(with: str)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        if(keyboardShown){
            self.view.frame.origin.y = -150
            isEdit = true
        }
    }
    
    @objc func keyboardWillHide(_ notification:NSNotification) {
        if( isEdit ){
            self.view.frame.origin.y = 0
            isEdit = false
        }
    }
    
}

//
//  MyPageUserInfoVC.swift
//  BabyClosetIOS
//
//  Created by 박경선 on 02/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

import UIKit

class MyPageUserInfoVC: UIViewController, UITextFieldDelegate {
    
    let picker = UIImagePickerController()
    
    let nameUnderLine = CALayer()
    let idUnderLine = CALayer()
    let passwdUnderLine = CALayer()
    
    @IBOutlet weak var nickNameTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var idTF: UITextField!
    @IBOutlet weak var passwdTF: UITextField!
    
    @IBOutlet weak var nameCV: UIView!
    @IBOutlet weak var passwdCV: UIView!
    @IBOutlet weak var idCV: UIView!
    
    @IBOutlet weak var profileImg: UIButton!
    @IBOutlet weak var changeButton: UIButton!
    
    let networkManager = NetworkManager()
    var userNickname = ""
    var userPw = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.title = "마이페이지"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.B17]
        
        picker.delegate = self
        initialTextField(nickNameTF)
        initialTextField(passwdTF)
        passwdTF.isUserInteractionEnabled = false
        nameTF.isUserInteractionEnabled = false
        idTF.isUserInteractionEnabled = false
        getUserInfoNetwork()
        
        nameCV.setUnderLine(border: nameUnderLine, color: UIColor.gray219.cgColor)
        passwdCV.setUnderLine(border: idUnderLine, color: UIColor.gray219.cgColor)
        idCV.setUnderLine(border: passwdUnderLine, color: UIColor.gray219.cgColor)
        
        let height = profileImg.frame.height / 2
        profileImg.roundCorners(corners: [.allCorners], radius: height)
        
    }
    
    func initialTextField(_ textField: UITextField ){
        textField.delegate = self
        textField.tintColor = .mainYellow
        textField.addTarget(self, action: #selector( self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if nickNameTF.text == "" {
            nickNameTF.font = UIFont(name: "SeoulNamsanM", size: 12)
        } else {
            nickNameTF.font = UIFont(name: "SeoulNamsanB", size: 16)
        }
        if passwdTF.text == "" {
            passwdTF.font = UIFont(name: "SeoulNamsanM", size: 12)
        } else {
            passwdTF.font = UIFont(name: "SeoulNamsanB", size: 16)
        }
    }
    
    func getUserInfoNetwork(){
        networkManager.getUserInfo { [weak self] (success, error) in
            if success == nil && error != nil {
                self?.simpleAlert(title: "", message: "네트워크 오류입니다.")
            }
            else if success != nil && error == nil {
                guard let stat = success?.status else {
                    if let msg = success?.message {
                        self?.simpleAlert(title: "", message: msg)
                    }
                    return
                }
                self?.nickNameTF.text = success?.data?.nickname
                self?.nameTF.text = success?.data?.username
                self?.idTF.text = success?.data?.userId
                let img = success?.data?.profileImage?.urlToImage()
                self?.profileImg.setImage(img, for: .normal)
                self?.passwdTF.text = "비밀번호를입력"
            }
            self?.userNickname = (self?.nickNameTF.text)!
        }
    }
    
    @IBAction func completeAction(_ sender: Any) {
        self.view.endEditing(true)
        changeButton.isHidden = false
        passwdTF.textColor = .gray219
        
        if nickNameTF.text == userNickname {
            userNickname = ""
        } else {
            userNickname = gsno(nickNameTF.text)
        }
        if passwdTF.text == "비밀번호를입력" {
            userPw = ""
        } else {
            userPw = gsno(passwdTF.text)
        }
        print("userNickname  : ", userNickname)
        print("userPw  : ", userPw)
        if let image = profileImg.currentImage?.jpegData(compressionQuality: 1.0) {
            networkManager.setUserInfo(nickname: userNickname, password: userPw, image: image){ [weak self] (success, fail, error) in
                print("setUserInfo, success : ", success)
                if success == nil && fail == nil && error != nil {
                    self?.simpleAlert(title: "", message: "네트워크 오류입니다.")
                }
                else if success == nil && error == nil {
                    guard let stat = success?.status, stat < 300 else {
                        if let msg = fail?.message {
                            self?.simpleAlert(title: "", message: msg)
                        }
                        return
                    }
                    self?.simpleAlert(title: "", message: "변경되었습니다.")
                }
            }
        }
    }
    
    @IBAction func changePwAction(_ sender: Any) {
        if changeButton.currentTitle == "변경하기" {
            changeButton.setTitle("확인", for: .normal)
            changeButton.widthAnchor.constraint(equalToConstant: 72).isActive = true
            passwdTF.isUserInteractionEnabled = true
            passwdTF.textColor = .gray38
        } else {
            diablePasswdTF()
        }
    }
    
    func diablePasswdTF(){
        if gsno(passwdTF.text) != "비밀번호를입력" {
            if !gsno(passwdTF.text).isValid("^(?=.*[a-zA-Z])(?=.*[0-9]).{1,}$") {
                self.simpleAlert(title: "", message: "비밀번호를 형식에 맞게 입력해주세요.")
            }
        } else {
            changeButton.setTitle("변경하기", for: .normal)
            changeButton.widthAnchor.constraint(equalToConstant: 92).isActive = true
            passwdTF.isUserInteractionEnabled = false
            passwdTF.textColor = .gray219
            self.view.endEditing(true)
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let clearImage = UIImage(named: "delete")!
        textField.clearButtonWithImage(clearImage)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let emptyImage = UIImage()
        textField.clearButtonWithImage(emptyImage)
        if textField == nickNameTF {
            
            if !gsno(nickNameTF.text).isValid("^(?=[가-힣ㄱ-ㅎㅏ-ㅣ]).{1,8}$") {
                self.simpleAlert(title: "", message: "아이디를 형식에 맞게 입력해주세요.")
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if changeButton.currentTitle == "확인" {
            let alert = UIAlertController(title: "", message: "비밀번호를 바꾸시겠습니까?", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default) { (action) in
                self.diablePasswdTF()
            }
            let no = UIAlertAction(title: "취소", style: .cancel, handler : nil)
            alert.addAction(ok)
            alert.addAction(no)
            present(alert, animated: true, completion: nil)
        } else {
            self.view.endEditing(true)
        }
    }
}

extension MyPageUserInfoVC : UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBAction func editProfileImgAction(_ sender: Any) {
        let alert =  UIAlertController(title: "프로필 사진 편집", message: "프로필 사진을 변경해보세요!", preferredStyle: .actionSheet)
        
        let library =  UIAlertAction(title: "사진앨범", style: .default) { (action) in self.openLibrary() }
        let camera =  UIAlertAction(title: "카메라", style: .default) { (action) in self.openCamera() }
        let defaultProfile = UIAlertAction(title: "기본 이미지로 변경", style: .default) { (action) in self.setDefaultImg() }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(library)
        alert.addAction(camera)
        alert.addAction(cancel)
        alert.addAction(defaultProfile)
        
        present(alert, animated: true, completion: nil)
    }
    
    func setDefaultImg(){
        profileImg.setImage(UIImage(named: "myPageDefault"), for: .normal)
    }
    
    func openLibrary(){
        picker.sourceType = .photoLibrary
        present(picker, animated: false, completion: nil)
    }
    
    func openCamera(){
        picker.sourceType = .camera
        present(picker, animated: false, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        profileImg.setImage(image, for: .normal)
        dismiss(animated: true, completion: nil)
    }
}

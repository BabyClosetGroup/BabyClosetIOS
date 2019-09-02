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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.title = "마이페이지"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.B17]
        
        picker.delegate = self
        nickNameTF.delegate = self
        nameTF.delegate = self
        idTF.delegate = self
        passwdTF.delegate = self
        passwdTF.isUserInteractionEnabled = false
        
        nameCV.setUnderLine(border: nameUnderLine, color: UIColor.gray219.cgColor)
        passwdCV.setUnderLine(border: idUnderLine, color: UIColor.gray219.cgColor)
        idCV.setUnderLine(border: passwdUnderLine, color: UIColor.gray219.cgColor)
        
        nickNameTF.tintColor = UIColor.mainYellow
        nameTF.tintColor = UIColor.mainYellow
        idTF.tintColor = UIColor.mainYellow
        passwdTF.tintColor = UIColor.mainYellow
        
        let height = profileImg.frame.height / 2
        
        profileImg.roundCorners(corners: [.allCorners], radius: height)
    }
    
    @IBAction func completeAction(_ sender: Any) {
        // 대충 빈칸이 있으면 안된다는 코드
        // 대충 서버랑 통신한다는 코드
        changeButton.isHidden = false
        passwdTF.textColor = .gray219
    }
    
    @IBAction func changePwAction(_ sender: Any) {
        passwdTF.isUserInteractionEnabled = true
        passwdTF.textColor = .gray38
        changeButton.isHidden = true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let clearImage = UIImage(named: "delete")!
        textField.clearButtonWithImage(clearImage)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let emptyImage = UIImage()
        textField.clearButtonWithImage(emptyImage)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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

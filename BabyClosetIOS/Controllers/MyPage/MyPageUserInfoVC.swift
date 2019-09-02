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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.title = "마이페이지"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "SeoulNamsanB", size: 17)!]
        
        picker.delegate = self
        nickNameTF.delegate = self
        nameTF.delegate = self
        idTF.delegate = self
        passwdTF.delegate = self
        
        nameCV.setUnderLine(border: nameUnderLine, color: UIColor.underLineGray.cgColor)
        passwdCV.setUnderLine(border: idUnderLine, color: UIColor.underLineGray.cgColor)
        idCV.setUnderLine(border: passwdUnderLine, color: UIColor.underLineGray.cgColor)
        
        nickNameTF.tintColor = UIColor.mainYellow
        nameTF.tintColor = UIColor.mainYellow
        idTF.tintColor = UIColor.mainYellow
        passwdTF.tintColor = UIColor.mainYellow
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
        let alert =  UIAlertController(title: "원하는 타이틀", message: "원하는 메세지", preferredStyle: .actionSheet)
        
        
        let library =  UIAlertAction(title: "사진앨범", style: .default) { (action) in self.openLibrary()
        }
        
        let camera =  UIAlertAction(title: "카메라", style: .default) { (action) in
            self.openCamera()
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        
        alert.addAction(library)
        
        alert.addAction(camera)
        
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func openLibrary(){
        
        picker.sourceType = .photoLibrary
        
        present(picker, animated: false, completion: nil)
        
    }
    
    func openCamera(){
        
        picker.sourceType = .camera
        
        present(picker, animated: false, completion: nil)
        
    }
    
    
    
    출처: https://zeddios.tistory.com/125 [ZeddiOS]
}

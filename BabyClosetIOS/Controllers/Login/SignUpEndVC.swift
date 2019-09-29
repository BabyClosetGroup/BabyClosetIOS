//
//  SignUpEndVC.swift
//  BabyClosetIOS
//
//  Created by 박경선 on 01/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

import UIKit

class SignUpEndVC: UIViewController {
    var nickname: String = ""
//    var id: String = ""
//    var pwd: String = ""
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nickname = UserDefaults.standard.string(forKey: "nickname") ?? "유저"
        label.text = "\(nickname)님, 환영 합니다!"
    }
    
    @IBAction func goMainAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.present(vc, animated: true, completion: nil)
//        let sb = UIStoryboard(name: "Main", bundle: nil)
//        let vc = sb.instantiateViewController(withIdentifier: "CustomizedTabBarController") as! CustomizedTabBarController
//        self.present(vc, animated: true, completion: nil)
    }
}

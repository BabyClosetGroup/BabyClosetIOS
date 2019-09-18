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
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "\(nickname)님, 환영 합니다!"
    }
    
    @IBAction func goMainAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dvc = storyboard.instantiateViewController(withIdentifier: "MainView")
        self.present(dvc, animated: true, completion: nil)
    }
}

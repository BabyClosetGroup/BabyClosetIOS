//
//  SignUpEndVC.swift
//  BabyClosetIOS
//
//  Created by 박경선 on 01/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

import UIKit

class SignUpEndVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func goMainAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dvc = storyboard.instantiateViewController(withIdentifier: "MainView")
        self.present(dvc, animated: true, completion: nil)
    }
}

//
//  SplashVC.swift
//  BabyClosetIOS
//
//  Created by 박경선 on 28/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

import UIKit

class SplashVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        var imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        let splashGif = UIImage.gifImageWithName(name: "splash")
        imgView = UIImageView(image: splashGif)
        self.view.addSubview(imgView)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
            self.goMain()
        }
    }
    
    func goMain(){
        if let autoLogin: Bool = UserDefaults.standard.bool(forKey: "autoLogin"), autoLogin {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "CustomizedTabBarController") as! CustomizedTabBarController
            self.present(vc, animated: true, completion: nil)
            
        } else {
            performSegue(withIdentifier: "goMain", sender: nil)
        }
    }
}

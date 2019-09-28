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
        performSegue(withIdentifier: "goMain", sender: nil)
    }
}

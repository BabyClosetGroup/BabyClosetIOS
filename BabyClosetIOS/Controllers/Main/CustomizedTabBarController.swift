//
//  CustomizedTabBarController.swift
//  BabyClosetIOS
//
//  Created by 최리안 on 16/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

import UIKit
import SwiftIcons


class CustomizedTabBarController: UITabBarController, UITabBarControllerDelegate {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func viewDidLoad() {
        setupMiddleButton()
        super.viewDidLoad()
        self.delegate = self
    }
    
    // TabBarButton – Setup Middle Button
    func setupMiddleButton() {
        
        let middleBtn = UIButton(frame: CGRect(x: (self.view.bounds.width / 2)-28, y: -28, width: 56, height: 56))
        
        let btnImage: UIImage? = UIImage(named: "writeBtn")
        middleBtn.setImage(btnImage, for: UIControl.State.normal)
        middleBtn.backgroundColor = .clear
        middleBtn.layer.cornerRadius = 28
        middleBtn.layer.shadowColor = UIColor.gray.cgColor
        middleBtn.layer.shadowOffset = CGSize(width:0, height:5)
        middleBtn.layer.shadowRadius = 4
        middleBtn.layer.shadowOpacity = 1
        
        //add to the tabbar and add click event
        self.tabBar.addSubview(middleBtn)
        middleBtn.addTarget(self, action: #selector(self.menuButtonAction), for: .touchUpInside)
        
        self.view.layoutIfNeeded()
        middleBtn.layer.zPosition = -1
    }
    
    // Menu Button Touch Action
    @objc func menuButtonAction(sender: UIButton) {
        self.selectedIndex = 2   //to select the middle tab. use "1" if you have only 3 tabs.
        let sb = UIStoryboard(name: "Posting", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "PostingNavigation") as! UINavigationController
        self.present(vc, animated: true, completion: nil)
    }
}


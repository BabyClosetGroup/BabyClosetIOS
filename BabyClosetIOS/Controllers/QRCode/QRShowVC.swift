//
//  QRShowVC.swift
//  BabyClosetIOS
//
//  Created by 최리안 on 20/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

import UIKit

class QRShowVC: UIViewController {
    var postid: Int = 0
    let networkManager = NetworkManager()

    @IBOutlet var postitle: UILabel!
    @IBOutlet var qrcode: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        setNavigationBar()
        getQRNetwork()

    }
    func setNavigationBar() {
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = UIColor.gray38
        navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.shouldRemoveShadow(true)
        
        self.navigationItem.title = "QR인증하기"
        
    }
    func getQRNetwork() {
        networkManager.getQRCode(postIdx: postid){ [weak self] (success, error) in
            if success == nil && error != nil {
                self?.simpleAlert(title: "", message: "네트워크 오류입니다.")
            }
            else if success != nil && error == nil {
                guard success?.success ?? false else {
                    if let msg = success?.message {
                        self?.simpleAlert(title: "", message: msg)
                    }
                    return
                }
                self?.postitle.text = success?.data?.postTitle ?? ""
                self?.qrcode.image = success?.data?.qrcode?.urlToImage()
                self?.postitle.sizeToFit()
            }
        }
    }

    

}

//
//  CompleteTVC.swift
//  BabyClosetIOS
//
//  Created by 박경선 on 20/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

import UIKit

class CompleteTVC: UITableViewCell {
    
    @IBOutlet weak var imgView: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var area: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var shareWho: UILabel!
    @IBOutlet weak var isRated: UILabel!
    @IBOutlet weak var ratingButton: UIButton!
    
    var receiveIdx: Int?
    var postIdx: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgView.backgroundColor = UIColor(white: 1.0, alpha: 0.0)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func showDetail(_ sender: Any) {
        let storyboard = UIStoryboard(name: "MyPage", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MyPageStarVC") as! MyPageStarVC
        vc.userIdx = self.receiveIdx
        vc.postIdx = self.postIdx
        self.window?.rootViewController?.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func rating(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "MyPage", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MyPageSharingInfoVC") as! MyPageSharingInfoVC
        vc.receiveIdx = self.receiveIdx
        vc.modalPresentationStyle = .overCurrentContext
//        self.window?.rootViewController?.present(vc, animated: false, completion: nil)
        self.window?.rootViewController = vc
        self.window?.makeKeyAndVisible()
    }
}

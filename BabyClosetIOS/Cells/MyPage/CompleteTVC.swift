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
    let userIdx: Int? = 0
    let postIdx: Int? = 0
    
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
        self.window?.rootViewController?.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func rating(_ sender: Any) {
        let storyboard = UIStoryboard(name: "MyPage", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MyPageSharingInfoVC") as! MyPageSharingInfoVC
        
        vc.modalPresentationStyle = .overCurrentContext
        self.window?.rootViewController?.present(vc, animated: false, completion: nil)
    }
}

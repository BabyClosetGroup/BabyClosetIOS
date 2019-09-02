//
//  completeTVC.swift
//  BabyClosetIOS
//
//  Created by 박경선 on 02/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

import UIKit

class CompleteTVC: UITableViewCell {
    
    @IBOutlet weak var profileImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func goStarAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "MyPage", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MyPageStarVC") as! MyPageStarVC
        self.window?.rootViewController?.present(vc, animated: true, completion: nil)
    }
    @IBAction func showInfoAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "MyPage", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MyPageSharingInfoVC") as! MyPageSharingInfoVC
        vc.modalPresentationStyle = .overCurrentContext
        self.window?.rootViewController?.present(vc, animated: false, completion: nil)
    }
    
}

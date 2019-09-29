//
//  IncompleteTVC.swift
//  BabyClosetIOS
//
//  Created by 박경선 on 02/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

import UIKit
class IncompleteTVC: UITableViewCell {
    @IBOutlet weak var mainImage: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var area: UILabel!
    @IBOutlet weak var register: UILabel!
    var postIdx: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @IBAction func sharingAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "MyPage", bundle: nil)
        let base  = storyboard.instantiateViewController(withIdentifier: "MyPageShareVC") as! MyPageShareVC
        let vc = storyboard.instantiateViewController(withIdentifier: "MyPageShareDetailVC") as! MyPageShareDetailVC
        vc.postIdx = postIdx
        base.present(vc, animated: true, completion: nil)
        base.dismiss(animated: true, completion: nil)
//        if let rvc = self.window?.rootViewController {
//            print("이거 되냐..." , vc)
//            print("이거 되냐..." , rvc)
//            rvc.present(vc, animated: true)
//        }
    }
    
}



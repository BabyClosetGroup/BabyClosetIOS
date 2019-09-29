//
//  IncompleteTVC.swift
//  BabyClosetIOS
//
//  Created by 박경선 on 02/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

import UIKit

protocol TableViewCellDelegate: class{
    func buttonDidClicked(postIdx: Int)
}

class IncompleteTVC: UITableViewCell {
    @IBOutlet weak var mainImage: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var area: UILabel!
    @IBOutlet weak var register: UILabel!
    var postIdx: Int?
    var delegate: TableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @IBAction func sharingAction(_ sender: Any) {
        print("\n\n\nn\n\n\n\n\n\n\n\n\n\n hjhjhjhjhjhjhjh")
        let storyboard = UIStoryboard(name: "MyPage", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MyPageShareDetailVC") as! MyPageShareDetailVC
        vc.postIdx = postIdx
        delegate?.buttonDidClicked(postIdx: postIdx ?? -1)
        
//        if let rvc = self.window?.rootViewController {
//            print("이거 되냐..." , vc)
//            print("이거 되냐..." , rvc)
//            rvc.present(vc, animated: true)
//        }
    }
    
}



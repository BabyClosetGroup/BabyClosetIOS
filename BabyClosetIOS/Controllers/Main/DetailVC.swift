//
//  DetailVC.swift
//  BabyClosetIOS
//
//  Created by 최리안 on 23/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet var titleImg: UIImageView!
    @IBOutlet var detailTitle: UILabel!
    @IBOutlet var dday: UILabel!
    @IBOutlet var categoryCollection: UICollectionView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var userImg: UIImageView!
    @IBOutlet var content: UITextView!
    @IBOutlet var star1: UIImageView!
    @IBOutlet var star2: UIImageView!
    @IBOutlet var star3: UIImageView!
    @IBOutlet var star4: UIImageView!
    @IBOutlet var star5: UIImageView!
    @IBOutlet var apply: UIButton!
    var categorys: [String] = ["서울 전체", "강남구", "강동구", "강북구", "강서구", "관악구", "광진구", "구로구", "금천구", "노원구", "도봉구", "동대문구", "동작구", "마포구", "서대문구", "서초구", "성동구", "성북구", "송파구", "양천구"]
    
    
    @IBAction func applyAction(_ sender: Any) {
    }
    
    @IBAction func actionSheet(_ sender: Any) {

//        alert의 폰트를 바꾸려면??
//        let alert = UIAlertController(title: "",
//                                      message: "",
//                                      preferredStyle: .alert)
//        Here's how we'll set up the font and size of the title and message fields:
//        // Change font of the title and message
//        let titleFont:[String : AnyObject] = [ NSFontAttributeName : UIFont(name: "AmericanTypewriter", size: 18)! ]
//        let messageFont:[String : AnyObject] = [ NSFontAttributeName : UIFont(name: "HelveticaNeue-Thin", size: 14)! ]
//        let attributedTitle = NSMutableAttributedString(string: "Multiple buttons", attributes: titleFont)
//        let attributedMessage = NSMutableAttributedString(string: "Select an Action", attributes: messageFont)
//        alert.setValue(attributedTitle, forKey: "attributedTitle")
//        alert.setValue(attributedMessage, forKey: "attributedMessage")
//
        let userAlert = UIAlertController(title: "정말로 삭제하시겠습니까?", message: nil, preferredStyle: .alert)
        let yes = UIAlertAction(title: "확인", style: .default) { (action) in
            
        }
        let no = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        userAlert.addAction(no)
        userAlert.addAction(yes)

        present(userAlert, animated: false) {
            
        }
        
        let etcReportAlert = UIAlertController(title: "기타(직접 입력)", message: "신고 사유를 적어주세요", preferredStyle: .alert)
        let etcYes = UIAlertAction(title: "확인", style: .default) { (action) in
            
        }
        etcReportAlert.addTextField { (text) in
            text.textColor = UIColor.cyan
            text.placeholder = "??아무거나 쓰지마;"
//            self.myLabel.text = alert.textFields?[0].text
            
        }
        etcReportAlert.addAction(no)
        etcReportAlert.addAction(etcYes)
        
        present(etcReportAlert, animated: false) {
            
        }
        
        let reportAlert = UIAlertController(title: "정말로 삭제하시겠습니까?", message: nil, preferredStyle: .alert)
        let reportYes = UIAlertAction(title: "확인", style: .default, handler: nil)
        reportAlert.addAction(reportYes)
        present(reportAlert, animated: false) {
            
        }
        
        let userActionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let modify = UIAlertAction(title: "수정하기", style: .default, handler: nil)
        let delete = UIAlertAction(title: "삭제하기", style: .default, handler: nil)
        let cancle = UIAlertAction(title: "Cancle", style: .cancel, handler: nil)
        userActionSheet.addAction(modify)
        userActionSheet.addAction(delete)
        userActionSheet.addAction(cancle)
        present(userActionSheet, animated: true) {
            
        }
        
        let buyerActionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let note = UIAlertAction(title: "쪽지보내기", style: .default, handler: nil)
        let report = UIAlertAction(title: "신고하기", style: .default, handler: nil)
        buyerActionSheet.addAction(note)
        buyerActionSheet.addAction(report)
        buyerActionSheet.addAction(cancle)
        present(buyerActionSheet, animated: true) {
            
        }
        
        let reportActionSheet = UIAlertController(title: "신고사유를 선택해주세요", message: nil, preferredStyle: .actionSheet)
        let op1 = UIAlertAction(title: "잠수", style: .default, handler: nil)
        let op2 = UIAlertAction(title: "불량물건", style: .default, handler: nil)
        let op3 = UIAlertAction(title: "기타(직접 입력)", style: .default, handler: nil)
        reportActionSheet.addAction(op1)
        reportActionSheet.addAction(op2)
        reportActionSheet.addAction(op3)
        reportActionSheet.addAction(cancle)
        present(reportActionSheet, animated: true) {
            
        }
    }
    override func viewDidLoad() {
        categoryCollection.delegate = self
        categoryCollection.dataSource = self
        
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        
        let nibName = UINib(nibName: "CategoryCVC", bundle: nil)
        categoryCollection.register(nibName, forCellWithReuseIdentifier: "CategoryCVC")

        setStar(num: 4)
        apply.layer.zPosition = 100
    }
    
    func setStar(num: Int64) {
        var stars: [UIImageView] = [star1, star2, star3, star4, star5]
        for i in 0..<stars.count {
            if (num > i) {
                stars[i].image = UIImage(named: "img2")
            } else {
                stars[i].image = UIImage(named: "img3")
            }
        }
    }

}

extension DetailVC : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categorys.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoryCollection.dequeueReusableCell(withReuseIdentifier: "CategoryCVC", for: indexPath) as! CategoryCVC
        cell.category.setTitle(categorys[indexPath.row], for: .normal)
        return cell
    }
    
}
extension DetailVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 82, height: 28)
    }
}

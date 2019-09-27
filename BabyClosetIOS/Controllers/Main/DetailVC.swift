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
    
    var postid: Int = 0
//    var post: detailPostContent
    var issender: Int = 0
    var star: Int = 0
    
    var area:[String] = []
    var age:[String] = []
    var cloth:[String] = []
    var category:[String] = []
    var isMsg: Int = 0
    
    let networkManager = NetworkManager()
    
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
        setNavigationBar()
        getPostDetailNetwork()
        setMsg()
        self.tabBarController?.tabBar.isHidden = true
        
        let nibName = UINib(nibName: "CategoryCVC", bundle: nil)
        categoryCollection.register(nibName, forCellWithReuseIdentifier: "CategoryCVC")
        setStar(num: 3)
//        titleImg.image = UIImage(named: self.imgTitle)
//        detailTitle.text = self.titleDetail
//        dday.text = "D-\(self.dayd)"
//        userName.text = "\(self.nameUser)님의 나눔 별점"
//        userImg.image = UIImage(named: self.imgUser)
//        content.text = self.Usercontent
//        categorys = self.category
        
    }
    func setMsg() {
        if isMsg == 0 {
//            msgBtn.image = UIImage(named: "btnLetter")
        } else {
//            msgBtn.image = UIImage(named: "btnLetterAlarm")
        }
    }
    
    
    func getPostDetailNetwork(){
        networkManager.getPostDetail (postIdx: postid){ [weak self] (success, error) in
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
                self?.isMsg = success?.data?.isNewMessage ?? 0
//                self?.post = success?.data?.detailPost ?? ""
                
                self?.detailTitle.text = success?.data?.detailPost?.postTitle
                self?.dday.text = success?.data?.detailPost?.deadline
                let name = success?.data?.detailPost?.nickname ?? ""
                self?.userName.text = "\(name)님의 나눔 별점"
                self?.userImg.image = success?.data?.detailPost?.profileImage?.urlToImage()
                if self?.userImg.image == nil {
                    self?.userImg.image = UIImage(named: "user")
                    //????????????
                }
                self?.userImg.image = success?.data?.detailPost?.profileImage?.urlToImage()
                self?.content.text = success?.data?.detailPost?.postContent
                
                self?.area = success?.data?.detailPost?.areaName ?? []
                self?.age = success?.data?.detailPost?.ageName ?? []
                self?.cloth = success?.data?.detailPost?.clothName ?? []
                self?.issender = success?.data?.detailPost?.isSender ?? 0
                self?.star = success?.data?.detailPost?.rating ?? 5
                self?.setStar(num: self?.star ?? 0)

                self?.category.append(contentsOf: self?.area ?? [])
                self?.category.append(contentsOf: self?.age ?? [])
                self?.category.append(contentsOf: self?.cloth ?? [])
                self?.categoryCollection.reloadData()
            }
        }
    }
    
    func setStar(num: Int) {
        var stars: [UIImageView] = [star1, star2, star3, star4, star5]
        for i in 0..<stars.count {
            if (num > i) {
                stars[i].image = UIImage(named: "img2")
            } else {
                stars[i].image = UIImage(named: "img3")
            }
        }
    }
    
    func setNavigationBar() {
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = UIColor.gray38
        navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.shouldRemoveShadow(true)
        
        self.navigationItem.title = "상품정보"
//        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.B17]
        
        let settingImg    = UIImage(named: "btnSetting")!
        let msgImg  = UIImage(named: "btnLetter")!
        
        let settingBtn = UIBarButtonItem(image: settingImg,  style: .plain, target: self, action:  #selector(buttonPressed(_:)))
        settingBtn.tag = 1
        let msgBtn   = UIBarButtonItem(image: msgImg,  style: .plain, target: self, action:  #selector(buttonPressed(_:)))
        msgBtn.tag = 2
        msgBtn.imageInsets = UIEdgeInsets(top: 0.0, left:45, bottom: 0, right: 0);

        self.navigationItem.rightBarButtonItems = [settingBtn, msgBtn]
        
        
    }
    @objc private func buttonPressed(_ sender: Any) {
        if let button = sender as? UIBarButtonItem {
            switch button.tag {
            case 1:
                self.view.backgroundColor = .blue
            case 2:
                // Change the background color to red.
                self.view.backgroundColor = .red
            default: print("error")
            }
        }
    }


}

extension DetailVC : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoryCollection.dequeueReusableCell(withReuseIdentifier: "CategoryCVC", for: indexPath) as! CategoryCVC
        cell.category.setTitle(category[indexPath.row], for: .normal)
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

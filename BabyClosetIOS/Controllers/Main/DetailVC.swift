//
//  DetailVC.swift
//  BabyClosetIOS
//
//  Created by 최리안 on 23/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

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
    @IBOutlet var imageslide: UIScrollView!
    @IBOutlet var page: UIPageControl!
    
    var isMsg: Int = 0
    var postid: Int = 0
    var userIdx: Int = 0
    var area:[String] = []
    var age:[String] = []
    var cloth:[String] = []
    var selected: [String: [String]] = [:]
    var category:[String] = []
    var issender: Int = 0
    var star: Int = 0
    var images: [String] = []
    var complaintext: String = ""
    
    let networkManager = NetworkManager()
    
    @objc func applyAction() {
        self.networkManager.share(postIdx: self.postid) { [weak self] (success, error) in
            if success == nil && error != nil {
                self?.simpleAlert(title: "", message: "네트워크 오류입니다.")
            } else if success != nil && error == nil {
                if success?.success == true {
                    print("나눔 신청하기")
                    self?.simpleAlert(title: "", message: "신청되셨습니다!")
                }
            }
        }
    }

    
    override func viewDidLoad() {
        categoryCollection.delegate = self
        categoryCollection.dataSource = self
        imageslide.delegate = self
        
        super.viewDidLoad()
//        setNavigationBar()
//        getPostDetailNetwork()
//        setMsg()
//        setScroll()
        self.tabBarController?.tabBar.isHidden = true
        
        let nibName = UINib(nibName: "CategoryCVC", bundle: nil)
        categoryCollection.register(nibName, forCellWithReuseIdentifier: "CategoryCVC")
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getPostDetailNetwork()
        setNavigationBar()
        setMsg()
        setScroll()
//        createFloatingButton()

        self.tabBarController?.tabBar.isHidden = true

    }
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeFloatingButton()
    }
    
    func setScroll() {
        page.numberOfPages = images.count
        print("길이?", images.count)
        for i in 0..<images.count{
            let imageView = UIImageView()
            imageView.image = images[i].urlToImage()
            imageView.contentMode = .scaleAspectFit //  사진의 비율을 맞춤.
            let xPosition = self.view.frame.width * CGFloat(i)
            
            imageView.frame = CGRect(x: xPosition, y: 0,
                                     width: self.view.frame.width,
                                     height: 376) // 즉 이미지 뷰가 화면 전체를 덮게 됨.
            
        imageslide.contentSize.width =
            self.view.frame.width * CGFloat(1+i)
        
        imageslide.addSubview(imageView)
        imageslide.isPagingEnabled = true
        imageslide.alwaysBounceVertical = false // 수직 스크롤 바운스 안되게 설정
        }
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
                self?.detailTitle.text = success?.data?.detailPost?.postTitle
                self?.content.text = success?.data?.detailPost?.postContent
                self?.dday.text = success?.data?.detailPost?.deadline
                self?.area = success?.data?.detailPost?.areaName ?? []
                self?.age = success?.data?.detailPost?.ageName ?? []
                self?.cloth = success?.data?.detailPost?.clothName ?? []
                
                let name = success?.data?.detailPost?.nickname ?? ""
                self?.userName.text = "\(name)님의 나눔 별점"
                self?.userIdx = success?.data?.detailPost?.userIdx ?? 0
                
                self?.userImg.image = success?.data?.detailPost?.profileImage?.urlToImage()
                self?.star = success?.data?.detailPost?.rating ?? 5
                self?.setStar(num: self?.star ?? 0)
                
                self?.issender = success?.data?.detailPost?.isSender ?? 0
                if self?.issender == 1 {
                    self?.removeFloatingButton()
                } else {
                    self?.createFloatingButton()
                }
                
                self?.images = success?.data?.detailPost?.postImages ?? []
                self?.setScroll()
                
                self?.category = []
                self?.category.append(contentsOf: self?.area ?? [])
                self?.category.append(contentsOf: self?.age ?? [])
                self?.category.append(contentsOf: self?.cloth ?? [])
                
                self?.selected["localList"] = self?.area
                self?.selected["ageList"] = self?.age
                self?.selected["categoryList"] = self?.cloth
                
                self?.categoryCollection.reloadData()
            }
        }
    }
    
    private var floatingButton: UIButton?
    private func createFloatingButton() {
        floatingButton = UIButton(type: .custom)
        floatingButton?.translatesAutoresizingMaskIntoConstraints = false
        floatingButton?.backgroundColor = .mainYellow
        floatingButton?.titleLabel?.font = UIFont(name: "SeoulNamsanB", size: 20)
        floatingButton?.setTitle("신청하기", for: .normal)
        floatingButton?.addTarget(self, action: #selector(applyAction), for: .touchUpInside)
        constrainFloatingButtonToWindow()
    }
    private func constrainFloatingButtonToWindow() {
        DispatchQueue.main.async {
            guard let keyWindow = UIApplication.shared.keyWindow,
                let floatingButton = self.floatingButton else { return }
            keyWindow.addSubview(floatingButton)
            keyWindow.trailingAnchor.constraint(equalTo: floatingButton.trailingAnchor,
                                                constant: 0).isActive = true
            keyWindow.bottomAnchor.constraint(equalTo: floatingButton.bottomAnchor,
                                              constant: 0).isActive = true
            floatingButton.widthAnchor.constraint(equalToConstant: 375).isActive = true
            floatingButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        }
    }
    private func removeFloatingButton(){
        guard floatingButton?.superview != nil else {  return }
        DispatchQueue.main.async {
            self.floatingButton?.removeFromSuperview()
            self.floatingButton = nil
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
        
        let settingBtn = UIBarButtonItem(image: settingImg,  style: .plain, target: self, action:  #selector(settingAlert))
        let msgBtn   = UIBarButtonItem(image: msgImg,  style: .plain, target: self, action:  #selector(goMessageView))
        msgBtn.imageInsets = UIEdgeInsets(top: 0.0, left:45, bottom: 0, right: 0);

        self.navigationItem.rightBarButtonItems = [settingBtn, msgBtn]

    }

    @objc func goMessageView(){
        print("메시지 클릭함")
        let storyboard = UIStoryboard(name: "Message", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Msg")
        navigationController?.pushViewController(vc, animated: true)
        
    }
    @objc func settingAlert(){
        removeFloatingButton()
        print("셋팅 클릭함")
        if issender == 0 {
            let buyerActionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let note = UIAlertAction(title: "쪽지보내기", style: .default, handler: { (action) in msgAction() })
            let report = UIAlertAction(title: "신고하기", style: .default, handler: { (action) in reportAlert() })
            let cancle = UIAlertAction(title: "Cancle", style: .cancel, handler: nil)
            
            buyerActionSheet.addAction(note)
            buyerActionSheet.addAction(report)
            buyerActionSheet.addAction(cancle)
            present(buyerActionSheet, animated: true, completion: nil)
            
        } else {
            let userActionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let modify = UIAlertAction(title: "수정하기", style: .default, handler: { (action) in modifyAction() })
            let delete = UIAlertAction(title: "삭제하기", style: .default, handler: { (action) in deletAlert() })
            let cancle = UIAlertAction(title: "Cancle", style: .cancel, handler: nil)
            userActionSheet.addAction(modify)
            userActionSheet.addAction(delete)
            userActionSheet.addAction(cancle)
            present(userActionSheet, animated: true, completion: nil)
        }
        func confirm () {
            let userAlert = UIAlertController(title: "신고가 완료되었습니다.", message: nil, preferredStyle: .alert)
            let yes = UIAlertAction(title: "확인", style: .default, handler:{(action) in self.createFloatingButton()})
            userAlert.addAction(yes)
            self.present(userAlert, animated: false, completion: nil)
        }
        func reportNetwork(tag: Int) {
            if tag == 1 {
                // 잠수 네트워크
                self.complaintext = "잠수"
                self.networkManager.report(postIdx: self.postid, complainReason: self.complaintext) { [weak self] (success, error) in
                    if success == nil && error != nil {
                        self?.simpleAlert(title: "", message: "네트워크 오류입니다.")
                    } else if success != nil && error == nil {
                        if success?.success == true {
                            print("신고 보내기 성공!")
//                          self?.simpleAlert(title: "", message: "수정")
                        }
                    }
                }
                print("신고 : 잠수")
            } else {
                // 불량물건 네트워크
                self.complaintext = "불량물건"
                self.networkManager.report(postIdx: self.postid, complainReason: self.complaintext) { [weak self] (success, error) in
                    if success == nil && error != nil {
                        self?.simpleAlert(title: "", message: "네트워크 오류입니다.")
                    } else if success != nil && error == nil {
                        if success?.success == true {
                            print("신고 보내기 성공!")
//                          self?.simpleAlert(title: "", message: "수정")
                        }
                    }
                }
                print("신고 : 불량물건")
            }
            confirm()
        }
        func writeReason() {
            let etcReportAlert = UIAlertController(title: "기타(직접 입력)", message: "신고 사유를 적어주세요", preferredStyle: .alert)
            let no = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            let yes = UIAlertAction(title: "확인", style: .default, handler: {
                action in
                confirm()
                if let label = etcReportAlert.textFields?[0].text {
                    self.complaintext = label
                    // 여기에 신고 보내기 네트워크
                    self.networkManager.report(postIdx: self.postid, complainReason: self.complaintext) { [weak self] (success, error) in
                        if success == nil && error != nil {
                            self?.simpleAlert(title: "", message: "네트워크 오류입니다.")
                        } else if success != nil && error == nil {
                            if success?.success == true {
                                print("신고 보내기 성공!")
    //                            self?.simpleAlert(title: "", message: "삭제")
                            }
                        }
                    }
                    print("신고 : 기타 --> \(label)")
                }
                confirm()
            })
            etcReportAlert.addTextField { (text) in
                text.placeholder = "신고사유"
            }
            etcReportAlert.addAction(no)
            etcReportAlert.addAction(yes)
            self.present(etcReportAlert, animated: false, completion: nil)
        }
        func msgAction() {
            // 메시지함 바로가기
            let storyboard = UIStoryboard(name: "Message", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "MessageDetailVC") as! MessageDetailVC
            vc.otherUserIdx = userIdx
            print("유저 정보 --->", userIdx)
            self.present(vc, animated: true, completion: nil)
//            self.window?.rootViewController?.present(vc, animated: true)
        }
        
        func reportAlert () {
            let reportActionSheet = UIAlertController(title: "신고사유를 선택해주세요", message: nil, preferredStyle: .actionSheet)
            let op1 = UIAlertAction(title: "잠수", style: .default, handler: { action in reportNetwork(tag: 1) })
            let op2 = UIAlertAction(title: "불량물건", style: .default, handler: { action in reportNetwork(tag: 2) })
            let op3 = UIAlertAction(title: "기타(직접 입력)", style: .default, handler: { (action) in writeReason() })
            let cancle = UIAlertAction(title: "Cancle", style: .cancel, handler: nil)
            
            reportActionSheet.addAction(op1)
            reportActionSheet.addAction(op2)
            reportActionSheet.addAction(op3)
            reportActionSheet.addAction(cancle)
            self.present(reportActionSheet, animated: true) {

            }
        }
        func modifyAction () {
            print("수정하기")
            let storyboard = UIStoryboard(name: "Posting", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "PostingMainTVC") as! PostingMainTVC
            vc.isModify = true
            vc.postidx = postid
            vc.localList = area
            vc.ageList = age
            vc.categoryList = cloth
            vc.selectedList = selected
            var day: String = ""
            if let deadline = dday.text {
                let idx = deadline.index(deadline.startIndex, offsetBy: 2)
                day = String(deadline[idx...])
            }
            vc.dday = day
            vc.dtitle = detailTitle.text ?? ""
            if let context = content.text {
                vc.content = context
            }
            
            vc.photos = images
            self.navigationController?.pushViewController(vc, animated: true)
//            self.present(vc, animated: true, completion: nil)
        }
        func deletAlert () {
            let userAlert = UIAlertController(title: "정말로 삭제하시겠습니까?", message: nil, preferredStyle: .alert)
            let yes = UIAlertAction(title: "확인", style: .default) { (action) in
                self.networkManager.deletePost(postIdx: self.postid) { [weak self] (success, error) in
                    if success == nil && error != nil {
                        self?.simpleAlert(title: "", message: "네트워크 오류입니다.")
                    } else if success != nil && error == nil {
                        if success?.success == true {
                            self?.simpleAlert(title: "", message: "삭제되었습니다.")
                        }
                    }
                }
                print("삭제 확인")
                // 삭제 엑션 후 어디로 가지? --> 메인 or 뒤로가기
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { // Change `2.0` to the desired number of seconds.
                    self.navigationController?.popViewController(animated: true)
                }
            }
            let no = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            userAlert.addAction(no)
            userAlert.addAction(yes)
            self.present(userAlert, animated: false, completion: nil)
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
        cell.isUserInteractionEnabled = false
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

extension DetailVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        page.currentPage = Int(pageIndex)
    }
}

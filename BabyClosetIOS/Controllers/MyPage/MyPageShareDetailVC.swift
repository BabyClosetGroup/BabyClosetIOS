//
//  MyPageShareDetailVC.swift
//  BabyClosetIOS
//
//  Created by 박경선 on 03/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

import UIKit

class MyPageShareDetailVC: UIViewController, UINavigationBarDelegate {
    
    @IBOutlet weak var applyCountLabel: UILabel!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var area: UILabel!
    @IBOutlet weak var requestNum: UILabel!
    @IBOutlet weak var sendMessage: UIButton!
    
    let networkManager = NetworkManager()
    var postIdx: Int?
    
    var requestList: [RequestShare] = []
    var selectIdx: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getNetwork()
        setNavigationBar()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 103.0
        tableView.allowsSelection = true
        tableView.register(UINib(nibName: "EmptyApplyCell", bundle: nil), forCellReuseIdentifier: "EmptyApplyCell")
        inactiveButton()
    }
    
    func setGesture() {
        let tapGesture = UITapGestureRecognizer(target: tableView.backgroundView, action: #selector(hideKeyboard(_:)))
        tapGesture.cancelsTouchesInView = true
        tableView.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard(_ sender: Any) {
        if let idx = selectIdx {
            tableView.deselectRow(at: idx, animated: true)
            inactiveButton()
        }
    }
    
    func inactiveButton(){
        sendMessage.isEnabled = false
        sendMessage.backgroundColor = UIColor.gray118
    }
    
    func activeButton(){
        sendMessage.isEnabled = true
        sendMessage.backgroundColor = UIColor.mainYellow
    }
    
    func setNavigationBar(){
        navBar.delegate = self
        let navItem = UINavigationItem()
        navBar.items = [navItem]
        navBar.tintColor = .gray118
        navBar.barTintColor = .white
        
        navItem.title = "신청자 목록"
        navItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "btn-back"), style: .plain, target: self, action: #selector(goBackAction))
        navBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.B17]
    }

    
    func getNetwork(){
        if let idx = postIdx {
            networkManager.getRequestShareList(postIdx: idx) { [weak self] (success, error) in
                if success == nil && error != nil {
                    self?.simpleAlert(title: "", message: "네트워크 오류입니다.")
                }
                else if success != nil && error == nil {
                    guard let stat = success?.status, stat < 300 else {
                        if let msg = success?.message {
                            self?.simpleAlert(title: "", message: msg)
                        }
                        return
                    }
                    let postInfo = success?.data?.post
                    self?.productName.text = postInfo?.postTitle
                    
                    self?.mainImg.image = postInfo?.mainImage?.urlToImage()
                    let num = postInfo?.applicantNumber
                    self?.requestNum.text = num
                    self?.applyCountLabel.text = "신청한 사람 (\(num ?? "0명"))"
                    if let area = postInfo?.areaName, area.count > 1 {
                        let attributedString = NSMutableAttributedString()
                            .normal(area[0], font: UIFont.M12)
                            .normal("외 \(area.count - 1)구", font: UIFont.L12)
                        self?.area.attributedText = attributedString
                    } else if let area = postInfo?.areaName{
                        let attributedString = NSMutableAttributedString()
                            .normal(area[0], font: UIFont.M12)
                        self?.area.attributedText = attributedString
                    }
                    self?.requestList = success?.data?.applicants ?? []
                    self?.tableView.reloadData()
                    
                }
            }
        }
    }
    
    @objc func goBackAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CustomizedTabBarController") as! CustomizedTabBarController
        let sb = UIStoryboard(name: "MyPage", bundle: nil)
        let nvc = sb.instantiateViewController(withIdentifier: "MyPage") as! UINavigationController
        let dvc = sb.instantiateViewController(withIdentifier: "MyPageShareVC") as! MyPageShareVC
        self.view.window?.rootViewController = vc
        vc.viewControllers?[1].present(nvc, animated: false) {
            nvc.pushViewController(dvc, animated: false)
        }
    }
    
    @IBAction func selectAndNoteAction(_ sender: Any) {
        tableView.allowsSelection = true
        let storyboard = UIStoryboard(name: "Message", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MessageDetailVC") as! MessageDetailVC
        vc.otherUserIdx = gino(requestList[gino(selectIdx?.row)].applicantIdx)
        self.present(vc, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let idx = selectIdx {
            tableView.deselectRow(at: idx, animated: true)
            inactiveButton()
        }
    }
}

extension MyPageShareDetailVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !requestList.isEmpty {
            return requestList.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !requestList.isEmpty {
            tableView.allowsSelection = true
            let cell = tableView.dequeueReusableCell(withIdentifier: "applyListCell", for: indexPath) as! ApplyListTVC
            let data = requestList[indexPath.row]
            if let img = data.profileImage?.urlToImage(){
                cell.addSubview(setImg(img: img, view: cell.profileImg))
            }
            if let nickname = data.applicantNickname, let rating = data.rating {
                let attributedString = NSMutableAttributedString()
                    .normal("\(nickname)님의 별점 ", font: UIFont.L16)
                    .normal("\(rating)점", font: UIFont.B16)
                cell.starLabel.attributedText = attributedString
            }
            cell.fillStar()
            return cell
        } else {
            tableView.allowsSelection = false
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyApplyCell") else { return UITableViewCell()}
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if !requestList.isEmpty {
            return 103
        } else{
            return 424
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        activeButton()
        selectIdx = indexPath
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        inactiveButton()
    }
    
    func setImg( img: UIImage, view: UIView) -> UIImageView {
        let imageView = UIImageView(frame: view.frame)
        imageView.image = img
        imageView.center = view.center
        let rad = view.frame.height / 2
        imageView.roundCorners(corners: [.allCorners], radius: rad)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }
}

//
//  MyPageReceiveVC.swift
//  BabyClosetIOS
//
//  Created by 박경선 on 02/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

import UIKit

class MyPageReceiveVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var receiveList: [ReceiveShare] = []
    let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.title = "받은 상품"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.B17]
        
        getCompletedNetwork()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "CompleteTVC", bundle: nil), forCellReuseIdentifier: "CompleteTVC")
        tableView.allowsSelection = false
    }
    
    func getCompletedNetwork(){
        networkManager.getReceivedShare { [weak self] (success, error) in
            print("  getReceivedShare  : ", success)
            if success == nil && error != nil {
                self?.simpleAlert(title: "", message: "네트워크 오류입니다.")
            }
            else if success != nil && error == nil {
                guard let stut = success?.status, stut < 300 else {
                    if let msg = success?.message {
                        self?.simpleAlert(title: "", message: msg)
                    }
                    return
                }
                self?.receiveList = success?.data?.allPost ?? []
                self?.tableView.reloadData()
            }
        }
    }
}

extension MyPageReceiveVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if receiveList.count != 0 {
            return receiveList.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if receiveList.count != 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CompleteTVC", for: indexPath) as! CompleteTVC
            let data = receiveList[indexPath.row]
            cell.title.text = data.postName
            if let img = data.mainImage?.urlToImage() {
                let imageView = cell.imgView.setImgView(img: img)
                cell.addSubview(imageView)
            }
            cell.date.text = data.sharedDate
            if data.senderIsRated == 0 {
                cell.isRated.text = "미부여"
            } else {
                cell.isRated.text = "\(gfno(data.rating))점"
            }
            if let area = data.areaName, area.count > 1 {
                let attributedString = NSMutableAttributedString()
                    .normal(area[0], font: UIFont.M12)
                    .normal("외 \(area.count - 1)구", font: UIFont.L12)
                cell.area.attributedText = attributedString
            } else if let area = data.areaName {
                let attributedString = NSMutableAttributedString()
                    .normal(area[0], font: UIFont.M12)
                cell.area.attributedText = attributedString
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyApplyCell")!
            return cell
        }
    }
}

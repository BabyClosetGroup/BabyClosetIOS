//
//  MessageMainVC.swift
//  BabyClosetIOS
//
//  Created by 박경선 on 03/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

import UIKit

class MessageMainVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let networkManager = NetworkManager()
    var messages: [Message] = []
    var selectedIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMessageNetwork()
        tableView.delegate = self
        tableView.dataSource = self
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationItem.title = "쪽지함"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.B17]
    }
    
    func getMessageNetwork(){
        networkManager.getMessageList { [weak self] (success, error) in
            print("getMessageList  : ", success)
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
                self?.messages = success?.data?.getNotes ?? []
                print("messages : ", self?.messages)
                self?.tableView.reloadData()
            }
        }
    }
}

extension MessageMainVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageListTVC", for: indexPath) as! MessageListTVC
        let data = messages[indexPath.row]
        cell.other.text = data.nickname
        cell.date.text = data.createdTime
        cell.shortMsg.text = data.lastContent
        cell.unreadCount.text = "+\(data.unreadCount ?? 0)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MessageDetailVC") as! MessageDetailVC
        vc.otherUserIdx = messages[indexPath.row].userIdx ?? 0
        self.present(vc, animated: true, completion: nil)
    }
}

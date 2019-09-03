//
//  MessageDetailVC.swift
//  BabyClosetIOS
//
//  Created by 박경선 on 03/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

import UIKit

class MessageDetailVC: UIViewController, UITextFieldDelegate {
    var messages: [MessageDetailModel] = [
        MessageDetailModel( content: "축하합니다. 여아 투피스 나눔자로 선정 되셨어요!", created: "2019/05/10", title: "보낸 쪽지"),
        MessageDetailModel( content: "우와! 감사합니다:) 지역이 중랑구 이시던데 저와 매우 가깝군요! 혹시 나눔날은 언제가 편하신가요? 저는 지금 육아휴직중이라 언제든지 괜찮아요. 편하신 요일과 시간 정해서 알려 주세요 !", created: "2019/05/11", title: "받은 쪽지"),
        MessageDetailModel( content: "우와! 감사합니다:) 지역이 중랑구 이시던데 저와 매우 가깝군요! 혹시 나눔날은 언제가 편하신가요? 저는 지금 육아휴직중이라 언제든지 괜찮아요. 편하신 요일과 시간 정해서 알려 주세요 ", created: "2019/05/12", title: "보낸 쪽지"),
        MessageDetailModel( content: "어머 저는 노원구 살아서 중랑구가 편하긴 한데 혹시 회기쪽이면 친정이 그 근처라서 가능 할 것 같아요.", created: "2019/05/12", title: "받은 쪽지"),
    ]
    
    @IBOutlet weak var messageTF: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        messageTF.delegate = self
        tableView.estimatedRowHeight = 122
        tableView.invalidateIntrinsicContentSize()
        tableView.delegate = self
        tableView.dataSource = self
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationItem.title = "쪽지함"
        
        messageTF.tintColor = .mainYellow
    }
    @IBAction func sendAction(_ sender: Any) {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        var month = ""
        var day = ""
        
        if components.month! < 10 {
            month = "0\(components.month!)"
        }
        if components.day! < 10 {
            day = "0\(components.day!)"
        }
        
        let date = "\(components.year!)/\(month)/\(day)"
        
        
        let newMessage =  MessageDetailModel( content: messageTF.text!, created: date, title: "보낸 쪽지")
        messages.append(newMessage)
        tableView.reloadData()
        messageTF.text = ""
//        let lastRowInLastSection = messages.count
        let indexPath = IndexPath(row: messages.count-1, section: 0 )
        self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
}

extension MessageDetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageBubbleTVC", for: indexPath) as! MessageBubbleTVC
        let title = messages[indexPath.row].title
        cell.contentLabel.text = messages[indexPath.row].content
        cell.dateLabel.text = messages[indexPath.row].created
        cell.titleLabel.text = title
        if title == "받은 쪽지" {
            cell.titleLabel.textColor = .mainYellow
            cell.bubble.borderColor = .mainYellow
            cell.bubble.roundCorners(corners: [.bottomLeft], radius: 0)
            cell.bubble.clipsToBounds = true
        } else {
            cell.titleLabel.textColor = .gray118
            cell.bubble.borderColor = .gray112
//            cell.bubble.roundCorners(corners: [.allCorners], radius: 8)
        }
        return cell
    }
    
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return UITableViewAutomaticDimension
    //    }
    
    
}



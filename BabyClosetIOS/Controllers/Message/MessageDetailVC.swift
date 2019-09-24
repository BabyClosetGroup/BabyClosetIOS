//
//  MessageDetailVC.swift
//  BabyClosetIOS
//
//  Created by 박경선 on 03/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//


// 비행기모양 누르면 바로 전송되는 것. enter치면 전송되는 것 고려해보기
// 말풍선.............ㅎr

import UIKit

class MessageDetailVC: UIViewController, UITextViewDelegate, UINavigationBarDelegate {
    var otherUser = ""
    var messages: [MessageDetailList] = []
    @IBOutlet weak var naviBar: UINavigationBar!
    @IBOutlet weak var backBarButton: UIBarButtonItem!
    @IBOutlet weak var messageTF: UITextView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sendContainer: UIView!
    
    var keyboardShown: Bool = false // 키보드 상태 확인
    var originY: CGFloat? // 오브젝트의 기본 위치
    var otherUserIdx: Int?
    let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageTF.delegate = self
        tableView.estimatedRowHeight = 122
        tableView.invalidateIntrinsicContentSize()
        tableView.delegate = self
        tableView.dataSource = self
        messageTF.tintColor = .mainYellow
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard(_:)))
        tapGesture.cancelsTouchesInView = true
        tableView.addGestureRecognizer(tapGesture)
        getMessageNetwork()
        
        naviBar.delegate = self
        naviBar.barTintColor = .white
        naviBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.B17]
        backBarButton.image = UIImage(named: "btn-Back")
        backBarButton.tintColor = .gray38
        backBarButton.action = #selector(goBack(_:))
    }
    
    @objc private func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func getMessageNetwork(){
        networkManager.getDetailMessageList(userIdx: gino(otherUserIdx)){ [weak self] (success, error) in
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
                self?.otherUser = success?.data?.receiver?.nickname ?? ""
                self?.naviBar.topItem?.title = self?.otherUser
                self?.messages = success?.data?.messages ?? []
                self?.tableView.reloadData()
            }
        }
    }
    
    @objc func hideKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unregisterForKeyboardNotifications()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        sendMessage()
        return true
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
            tableView.contentInset.bottom = keyboardHeight
            tableView.scrollIndicatorInsets.bottom = keyboardHeight
            tableView.scrollToRow(at: IndexPath(row: messages.count - 1, section: 0), at: .bottom, animated: true)
            tableView.setBottomInset(to: keyboardHeight)
            
            sendContainer.frame.origin.y -= (keyboardHeight - 18)
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        if let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
            sendContainer.frame.origin.y += (keyboardHeight - 18)
        }
        tableView.setBottomInset(to: 0.0)
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func sendAction(_ sender: Any) {
        sendMessage()
    }
    
    func sendMessage(){
        if messageTF.text == "" {
            //            simpleAlert(title: "메시지를 입력해주세요!", message: "")
        } else {
            let components = Calendar.current.dateComponents([.year, .month, .day], from: Date())
            var date = "\(components.year!)"
            
            if components.month! < 10 {
                date.append("/0\(components.month!)")
            }
            if components.day! < 10 {
                date.append("/0\(components.day!)")
            }
            
//            let newMessage =  MessageDetailList( content: messageTF.text!, created: date, title: "보낸 쪽지")
//            messages.append(newMessage)
            tableView.reloadData()
            scrollToBottom()
            messageTF.text = ""
        }
    }
    
    func scrollToBottom(){
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
        
    }
    
    func textViewDidChange(_ textView: UITextView) {
//        textView.sizeToFit()
    }
}

extension MessageDetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if messages.count != 0 {
            return messages.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if messages.count != 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MessageBubbleTVC", for: indexPath) as! MessageBubbleTVC
            let data = messages[indexPath.row]
            cell.contentLabel.text = data.noteContent
            cell.dateLabel.text = data.createdTime
            if data.noteType == 0 {
                cell.titleLabel.text = "보낸 쪽지"
                cell.titleLabel.textColor = .gray118
                cell.bubble.borderColor = .gray112
            } else {
                cell.titleLabel.text = "받은 쪽지"
                cell.titleLabel.textColor = .mainYellow
                cell.bubble.borderColor = .mainYellow
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyMessageCell") as! MessageEmptyTVC
            cell.label.text = "\(otherUser)님께"
            return cell
        }
    }
    
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        self.view.endEditing(true)
    //    }
    
    func changeImage(_ imageView: UIImageView, _ name: String) {
        guard let image = UIImage(named: name) else { return }
        imageView.image = image
            .resizableImage(withCapInsets:
                UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10),
                            resizingMode: .stretch)
        //            .withRenderingMode(.alwaysTemplate)
        
    }
    
    
    //    func makeBubbleView(bubble: UIView){
    //        let cardView = UIView()
    //        bubble.addSubview(cardView)
    ////        cardView.translatesAutoresizingMaskIntoConstraints = false
    //        print("bubble.frame.width - 32   ", bubble.frame.width - 32)
    //        print("bubble.frame.height - 200   ", bubble.frame.height - 200)
    //        print("bubble.frame.width - 32   ", bubble.frame.width - 32)
    //        print("bubble.frame.width - 32   ", bubble.frame.width - 32)
    //        cardView.widthAnchor.constraint(equalToConstant: bubble.frame.width - 32).isActive = true
    //        cardView.heightAnchor.constraint(equalToConstant: bubble.frame.height - 200).isActive = true
    //        cardView.centerXAnchor.constraint(equalTo: bubble.centerXAnchor).isActive = true
    //        cardView.centerYAnchor.constraint(equalTo: bubble.centerYAnchor).isActive = true
    //        //        cardView.topAnchor.constraint(equalTo: 0).isActive = true
    //
    //        cardView.backgroundColor = UIColor.gray219
    //        cardView.borderColor = UIColor.mainYellow
    //        cardView.borderWidth = 2
    //
    //        //        cardView.roundCorners(corners: [.allCorners], radius: 8)
    //
    //    }
    
    
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return UITableViewAutomaticDimension
    //    }
}



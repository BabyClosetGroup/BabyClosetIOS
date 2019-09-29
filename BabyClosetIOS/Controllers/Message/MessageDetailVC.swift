//
//  MessageDetailVC.swift
//  BabyClosetIOS
//
//  Created by 박경선 on 03/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

import UIKit

class MessageDetailVC: UIViewController, UITextViewDelegate, UINavigationBarDelegate {
    var otherUser = ""
    var messages: [MessageDetailList] = []
    let networkManager = NetworkManager()

    private let cellId = "cellId"
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var naviBar: UINavigationBar!
    @IBOutlet weak var backBarButton: UIBarButtonItem!
    @IBOutlet weak var messageTV: UITextView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var sendContainer: UIView!
    
    var keyboardShown: Bool = false // 키보드 상태 확인
    var originY: CGFloat = 0.0 // 오브젝트의 기본 위치
    var otherUserIdx: Int?
    var bottomC: CGFloat = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageTV.delegate = self
        collectionView.invalidateIntrinsicContentSize()
        collectionView.delegate = self
        collectionView.dataSource = self
        messageTV.tintColor = .mainYellow
        collectionView.register(ChatCell.self, forCellWithReuseIdentifier: cellId)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = true
        collectionView.addGestureRecognizer(tapGesture)
        getMessageNetwork()
        originY = self.containerView.frame.origin.y
        naviBar.delegate = self
        naviBar.barTintColor = .white
        naviBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.B17]
        backBarButton.image = UIImage(named: "btn-Back")
        backBarButton.tintColor = .gray38
        backBarButton.action = #selector(goBack)
        self.tabBarController?.tabBar.isHidden = true

        addShadowToBar()
//        messageTV.isScrollEnabled = false
    }
    
    func addShadowToBar() {
        let contactRect = CGRect(x: -5, y: 30, width: self.view.frame.width + 10, height: 15)
        let shadowPath = UIBezierPath(rect: contactRect)
        naviBar.layer.masksToBounds = false
        naviBar.layer.shadowColor = UIColor.gray118.cgColor
        naviBar.layer.shadowOffset = CGSize(width: 0, height: 10)
        naviBar.layer.shadowOpacity = 0.3
        naviBar.layer.shadowPath = shadowPath.cgPath
    }
    
    @objc private func goBack() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    func setDataNetwork(){
        networkManager.sendMessage(receiverIdx: gino(otherUserIdx), noteContent: gsno(messageTV.text)) { [weak self] (success, error) in
            if success == nil && error != nil {
                self?.simpleAlert(title: "", message: "네트워크 오류입니다.")
            } else if success != nil && error == nil {
                if success?.success != true {
                    self?.simpleAlert(title: "", message: self?.gsno(success?.message) ?? "")
                }
                self?.messageTV.text = ""
            }
        }
    }
    
    @IBAction func sendMessageAction(_ sender: Any) {
        if messageTV.text.trimmingCharacters(in: .whitespaces) == "" {
            return
        }
        setDataNetwork()
        getMessageNetwork()
    }
    
    func getMessageNetwork(){
        print("여긴 메시지함이야!", otherUserIdx)
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
                self?.collectionView.reloadData()
                self?.scrollToBottom()
            }
        }
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unregisterForKeyboardNotifications()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        messageTV.sizeToFit()
//        messageTV.isScrollEnabled = true
        return true
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
            if self.containerView.frame.origin.y == originY {
                self.containerView.frame.origin.y -= (keyboardHeight-20)
            }
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        self.containerView.frame.origin.y = originY
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func scrollToBottom(){
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
            self.collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
        }
    }
}

extension MessageDetailVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ChatCell
        let data = messages[indexPath.row]
        if data.noteType == 0 {
            cell.typeLabel.text = "받은 쪽지"
            cell.bubble.image = UIImage(named: "yellowBubble")!
            cell.typeLabel.textColor = .mainYellow
        } else {
            cell.typeLabel.text = "보낸 쪽지"
            cell.bubble.image = UIImage(named: "grayBubble")!
            cell.typeLabel.textColor = .gray118
        }
        cell.messageView.text = data.noteContent
        cell.timeLabel.text = data.createdTime
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let messageText = messages[indexPath.row].noteContent {
            let size = CGSize(width: view.frame.width, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let estimatedFrame = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.M12], context: nil)
            
            return CGSize(width: view.frame.width, height: estimatedFrame.height + 60)
        }
        return CGSize(width: view.frame.width, height: 100)
    }
}




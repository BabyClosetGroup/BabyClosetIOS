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

    private let cellId = "cellId"
    @IBOutlet weak var naviBar: UINavigationBar!
    @IBOutlet weak var backBarButton: UIBarButtonItem!
    @IBOutlet weak var messageTV: UITextView!
    @IBOutlet weak var tableView: UICollectionView!
    @IBOutlet weak var sendContainer: UIView!
    
    var keyboardShown: Bool = false // 키보드 상태 확인
    var originY: CGFloat? // 오브젝트의 기본 위치
    var otherUserIdx: Int?
    let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageTV.delegate = self
//        tableView.estimatedRowHeight = 122
        tableView.invalidateIntrinsicContentSize()
        tableView.delegate = self
        tableView.dataSource = self
        messageTV.tintColor = .mainYellow
        tableView.register(ChatCell.self, forCellWithReuseIdentifier: cellId)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard(_:)))
        tapGesture.cancelsTouchesInView = true
        tableView.addGestureRecognizer(tapGesture)
        getMessageNetwork()
        
        naviBar.delegate = self
        naviBar.barTintColor = .white
        naviBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.B17]
//        tableView.register(UINib(nibName: "MessageBubbleTVC", bundle: nil), forCellReuseIdentifier: "MessageBubbleTVC") as! MessageBubbleTVC
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
//            tableView.scrollToRow(at: IndexPath(row: messages.count - 1, section: 0), at: .bottom, animated: true)
//            tableView.setBottomInset(to: keyboardHeight)
            
            sendContainer.frame.origin.y -= (keyboardHeight - 18)
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        if let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
            sendContainer.frame.origin.y += (keyboardHeight - 18)
        }
//        tableView.setBottomInset(to: 0.0)
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
        if messageTV.text == "" {
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
//
            let newMessage =  MessageDetailList(content: messageTV.text!, created: date, title: 0)
            messages.append(newMessage)
            tableView.reloadData()
            scrollToBottom()
            messageTV.text = ""
        }
    }
    
    func scrollToBottom(){
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
//            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
//        textView.sizeToFit()
    }
}

extension MessageDetailVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = tableView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ChatCell
        let data = messages[indexPath.row]
        if data.noteType == 1 {
            cell.typeLabel.text = "받은 쪽지"
            cell.bubble.image = UIImage(named: "yellowBubble")!
            cell.typeLabel.textColor = .mainYellow
        } else {
            cell.typeLabel.text = "보낸 쪽지"
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

class ChatCell: BaseCell {
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        return view
    }()
    
    let typeLabel: UILabel = {
        let label = UILabel()
        label.text = "받은 쪽지"
        label.textColor = UIColor.gray112
        label.font = UIFont.M12
        return label
    }()
    
    let messageView: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.backgroundColor = UIColor.clear
        textView.text = "Your friend's message and something else..."
        textView.textColor = UIColor.gray38
        textView.font = UIFont.M15
        return textView
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "12:05 pm"
        label.font = UIFont.M12
        label.textColor = UIColor.gray219
        label.textAlignment = .right
        return label
    }()
    
    var bubble: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "grayBubble")!.resizableImage(withCapInsets: UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50), resizingMode: .stretch).withRenderingMode(.alwaysOriginal)
        return imgView
    }()
    
    override func setupViews() {
        setupContainerView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    private func setupContainerView() {
        let containerView = UIView()
        addSubview(containerView)
        addSubview(bubble)
        addConstraintsWithFormat(format: "H:|-16-[v0]|", views: containerView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: containerView)
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: bubble)
        addConstraintsWithFormat(format: "V:|[v0]-6-|", views: bubble)
        bubble.addSubview(typeLabel)
        bubble.addSubview(messageView)
        bubble.addSubview(timeLabel)
        
        bubble.addConstraintsWithFormat(format: "H:|-10-[v0][v1(120)]-10-|", views: typeLabel, timeLabel)
        bubble.addConstraintsWithFormat(format: "H:|-10-[v0]-22-|", views: messageView)
        bubble.addConstraintsWithFormat(format: "V:|-10-[v0(15)]-5-[v1]|", views: typeLabel, messageView)
        bubble.addConstraintsWithFormat(format: "V:|-10-[v0(15)]", views: timeLabel)
    }
    
}

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        backgroundColor = UIColor.blue
    }
}

extension UIView {
    
    func addConstraintsWithFormat(format: String, views: UIView...) {
        
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

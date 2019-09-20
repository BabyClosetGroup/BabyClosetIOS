//
//  PostingMainTVC.swift
//  BabyClosetIOS
//
//  Created by 박경선 on 05/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

import UIKit

class PostingMainTVC: UITableViewController, UITextFieldDelegate, UITextViewDelegate, SaveDataDelegate {
    
    @IBOutlet var imgButtons: [UIButton]!
    @IBOutlet weak var tagCollectionView: UICollectionView!
    @IBOutlet weak var deadLineLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var tagCollectionHeightC: NSLayoutConstraint!
    @IBOutlet weak var deadLineHeightC: NSLayoutConstraint!
    
    let picker = UIImagePickerController()
    let getImage = UIImage()
    var selectedButton:UIButton = UIButton()
    
    var localList: [String] = []
    var ageList: [String] = []
    var categoryList: [String] = []
    var selectedList: [String:[String]] = [:]
//        ["localList":[], "ageList":[], "categoryList": []]
    
    var deadLine: String = ""
    
    
    private var floatingButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setGesture()
        picker.delegate = self
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
        titleTextField.delegate = self
        contentTextView.delegate = self
        
        deadLineHeightC.constant = 0
        tagCollectionHeightC.constant = 0
        contentTextView.isScrollEnabled = false
        tagCollectionView.allowsSelection = false
        contentTextView.text = "내용을 입력해주세요."
        contentTextView.textColor = .gray219
        deadLineLabel.roundCorners(corners: [.allCorners], radius: 8)
        contentTextView.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        tagCollectionView.register(UINib(nibName: "PostingCategoryCell", bundle: nil), forCellWithReuseIdentifier: "HashTagCell")

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createFloatingButton()
        if categoryList.count == 0 {
            tagCollectionHeightC.constant = 0
        } else {
            tagCollectionHeightC.constant = 28
        }
        tagCollectionView.reloadData()
        tableView.reloadData()
        self.view.layoutIfNeeded()
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeFloatingButton()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if contentTextView.text == "내용을 입력해주세요." {
            contentTextView.text = ""
            contentTextView.textColor = .gray38
        }
    }
    
    func setGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: Selector("hideKeyboard"))
        tapGesture.cancelsTouchesInView = true
        tableView.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    func setNavigationBar(){
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationItem.title = "나눔하기"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.B17]
        self.navigationController?.navigationBar.shouldRemoveShadow(true)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    private func createFloatingButton() {
        floatingButton = UIButton(type: .custom)
        floatingButton?.translatesAutoresizingMaskIntoConstraints = false
        floatingButton?.backgroundColor = .mainYellow
        floatingButton?.setTitle("나눔 등록하기", for: .normal)
        floatingButton?.titleLabel?.font = UIFont(name: "SeoulNamsanB", size: 20)
        floatingButton?.addTarget(self, action: #selector(completeAction(_:)), for: .touchUpInside)
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
            floatingButton.widthAnchor.constraint(equalToConstant: self.tableView.bounds.size.width).isActive = true
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
    
    @objc private func completeAction(_ sender: Any) {
        if selectedList.isEmpty {
            self.simpleAlert(title: "카테고리를 선택해주세요!", message: "카테고리를 선택해야\n글을 작성할 수 있습니다.")
        } else if deadLine == "" {
            self.simpleAlert(title: "마감기한을 선택해주세요!", message: "마감기한을 선택해야\n글을 작성할 수 있습니다.")
        } else if titleTextField.text == "" {
            self.simpleAlert(title: "제목을 입력해주세요!", message: "제목을 입력하셔야\n글을 작성할 수 있습니다.")
        } else if contentTextView.text == "내용을 입력해주세요." {
            self.simpleAlert(title: "내용을 입력해주세요!", message: "내용을 입력하셔야\n글을 작성할 수 있습니다.")
        }
    }
    
    func addDeadLine(_ day: Int) {
        createFloatingButton()
        deadLineLabel.text = "\(day)일"
        deadLineHeightC.constant = 28
        tableView.reloadData()
        self.view.layoutIfNeeded()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        contentTextView.sizeToFit()
        contentView.frame.size.height = contentTextView.contentSize.height + 70
    }
    
    func saveData(data saveData:[String: [String]]) {
        localList = saveData["localList"]!
        ageList = saveData["ageList"]!
        categoryList = saveData["categoryList"]!
        tagCollectionView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! PostingCategoryVC
        destination.delegate = self
        destination.selectedList["localList"] = localList
        destination.selectedList["ageList"] = ageList
        destination.selectedList["categoryList"] = categoryList
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


extension PostingMainTVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBAction func editImgAction(_ sender: UIButton) {
        removeFloatingButton()
        selectedButton = sender
        
        let alert =  UIAlertController(title: "프로필 사진 편집", message: "프로필 사진을 변경해보세요!", preferredStyle: .actionSheet)
        
        let library =  UIAlertAction(title: "사진앨범", style: .default) { (action) in self.openLibrary() }
        let camera =  UIAlertAction(title: "카메라", style: .default) { (action) in self.openCamera() }
        let defaultProfile = UIAlertAction(title: "삭제하기", style: .default) { (action) in self.setDefaultImg(sender) }
        let cancel = UIAlertAction(title: "취소", style: .cancel) {(action) in self.createFloatingButton()}
        
        alert.addAction(library)
        alert.addAction(camera)
        alert.addAction(defaultProfile)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    func setDefaultImg(_ button: UIButton){
        if button == imgButtons[0] {
            selectedButton.setImage(UIImage(named: "mainImg"), for: .normal)
        }
        selectedButton.setImage(UIImage(named: "btn-selectImg"), for: .normal)
        createFloatingButton()
    }
    
    func openLibrary(){
        picker.sourceType = .photoLibrary
        present(picker, animated: false, completion: nil)
    }
    
    func openCamera(){
        picker.sourceType = .camera
        present(picker, animated: false, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        if let originalImage = info[.originalImage] as? UIImage {
            selectedButton.setImage(originalImage, for: .normal)
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func chooseDeadLineAction(_ sender: Any) {
        removeFloatingButton()
        let dead =  UIAlertController(title: "마감기한 선택", message: "", preferredStyle: .actionSheet)
        let one =  UIAlertAction(title: "1일", style: .default) { (action) in self.addDeadLine(1) }
        let two =  UIAlertAction(title: "2일", style: .default) { (action) in self.addDeadLine(2)}
        let three = UIAlertAction(title: "3일", style: .default) {(action) in self.addDeadLine(3)}
        let four = UIAlertAction(title: "4일", style: .default) {(action) in self.addDeadLine(4)}
        let cancel = UIAlertAction(title: "취소", style: .cancel) {(action) in self.createFloatingButton()}
        
        dead.addAction(one)
        dead.addAction(two)
        dead.addAction(three)
        dead.addAction(four)
        dead.addAction(cancel)
        
        present(dead, animated: true, completion: nil)
    }
    
}

extension PostingMainTVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return localList.count + ageList.count + categoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = tagCollectionView.dequeueReusableCell(withReuseIdentifier: "HashTagCell", for: indexPath) as! PostingCategoryCell
        if localList.count > indexPath.row {
            cell.tagLabel.text = localList[indexPath.row]
        } else if (localList.count + ageList.count ) > indexPath.row {
            cell.tagLabel.text = ageList[indexPath.row - localList.count]
        } else {
            let row = indexPath.row - ( localList.count + ageList.count )
            cell.tagLabel.text = categoryList[row]
        }
        cell.isSelected = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}

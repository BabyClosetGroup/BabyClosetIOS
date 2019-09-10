//
//  PostingMainTVC.swift
//  BabyClosetIOS
//
//  Created by 박경선 on 05/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

import UIKit

class PostingMainTVC: UITableViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet var imgButtons: [UIButton]!
    @IBOutlet weak var tagCollectionView: UICollectionView!
    @IBOutlet weak var deadLineLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    
    @IBOutlet weak var tagCollectionHeightC: NSLayoutConstraint!
    @IBOutlet weak var deadLineHeightC: NSLayoutConstraint!
    @IBOutlet weak var contentHeightC: NSLayoutConstraint!
//    @IBOutlet weak var contentTopC: NSLayoutConstraint!
    
    let picker = UIImagePickerController()
    let getImage = UIImage()
    var selectedButton:UIButton = UIButton()
    var categoryList: [String] = []
    var deadLine: String = ""
    var conHeight = 194
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tagCollectionView.allowsSelection = false
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationItem.title = "나눔하기"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.B17]
        self.navigationController?.navigationBar.shouldRemoveShadow(true)
        
        picker.delegate = self
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
        
        titleTextField.delegate = self
        contentTextView.delegate = self
        contentTextView.translatesAutoresizingMaskIntoConstraints = true
        contentTextView.sizeToFit()
//        contentTextView.isScrollEnabled = false
//        contentTextView.text = "내용을 입력해주세요"
        contentHeightC.constant = contentTextView.contentSize.height
        self.tableView.rowHeight = UITableView.automaticDimension
        
        deadLineLabel.roundCorners(corners: [.allCorners], radius: 8)
        deadLineHeightC.constant = 0
        
        tableView.estimatedRowHeight = 421
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("hi : ", categoryList)
        super.viewWillAppear(animated)
        if categoryList.count == 0 {
            tagCollectionHeightC.constant = 0
        } else {
            tagCollectionHeightC.constant = 28
        }
        self.view.layoutIfNeeded()
        tagCollectionView.reloadData()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func addDeadLine(_ day: Int) {
        deadLineLabel.text = "\(day)일"
        deadLineHeightC.constant = 28
        self.view.layoutIfNeeded()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        contentHeightC.constant = contentTextView.contentSize.height
        if contentHeightC.constant != CGFloat(conHeight) {
            contentHeightC.constant += 10
            tableView.rowHeight += 10
        }
        print("height : \(Date())", contentHeightC.constant)
        contentTextView.sizeToFit()
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}

extension PostingMainTVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBAction func editImgAction(_ sender: UIButton) {
        
        selectedButton = sender
        
        let alert =  UIAlertController(title: "프로필 사진 편집", message: "프로필 사진을 변경해보세요!", preferredStyle: .actionSheet)
        
        let library =  UIAlertAction(title: "사진앨범", style: .default) { (action) in self.openLibrary() }
        let camera =  UIAlertAction(title: "카메라", style: .default) { (action) in self.openCamera() }
        let defaultProfile = UIAlertAction(title: "삭제하기", style: .default) { (action) in self.setDefaultImg(sender) }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(library)
        alert.addAction(camera)
        alert.addAction(defaultProfile)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    func setDefaultImg(_ button: UIButton){
        if button == imgButtons[0] {
            selectedButton.setImage(UIImage(named: "btn-selectImgMain"), for: .normal)
        }
        selectedButton.setImage(UIImage(named: "btn-selectImg"), for: .normal)
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
            print("originalImage")
            selectedButton.setImage(originalImage, for: .normal)
        }
        //        button.setImage(image, for: .normal)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func chooseDeadLineAction(_ sender: Any) {
        let dead =  UIAlertController(title: "마감기한 선택", message: "..", preferredStyle: .actionSheet)
        let one =  UIAlertAction(title: "1일", style: .default) { (action) in self.addDeadLine(1) }
        let two =  UIAlertAction(title: "2일", style: .default) { (action) in self.addDeadLine(2)}
        let three = UIAlertAction(title: "3일", style: .default) {(action) in self.addDeadLine(3)}
        let four = UIAlertAction(title: "4일", style: .default) {(action) in self.addDeadLine(4)}
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
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
        return categoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = tagCollectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! PostingCategoryCell
        cell.tagLabel.text = categoryList[indexPath.row]
        cell.isSelectCollection = false
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return -6
    }
    
}

//
//  PostingCategoryVC.swift
//  BabyClosetIOS
//
//  Created by 박경선 on 05/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

import UIKit

protocol SaveDataDelegate: class {
    func saveData(data saveData:[String: [String]])
}
protocol FSaveDataDelegate:class{
    func saveFData(data saveData:[String: [String]])
}

class PostingCategoryVC: UIViewController, UIViewControllerTransitioningDelegate {
    
    let localList: [String] = ["서울 전체", "강남구", "강동구", "강북구", "강서구", "관악구", "광진구", "구로구", "금천구", "노원구", "도봉구", "동대문구", "동작구", "마포구", "서대문구", "서초구", "성동구", "성북구", "송파구", "양천구", "영등포구", "용산구", "은평구", "종로구", "중구", "중랑구"]
    let ageList: [String] = ["나이 전체", "3개월", "12개월", "24개월", "24~30개월"]
    let categoryList: [String] = ["카테고리 전체", "베스트", "배내옷", "바디슈트", "내의", "슬리핑가운", "원피스", "상의", "하의", "상하복"]
    
    weak var delegate: SaveDataDelegate?
    weak var delegateF: FSaveDataDelegate?
    var selectedList: [String:[String]] = ["localList":[], "ageList":[], "categoryList": []]
    var isFiltered = false
    @IBOutlet weak var localCollectionView: UICollectionView!
    @IBOutlet weak var ageCollectionView: UICollectionView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = UIColor.gray38
        self.navigationController?.navigationBar.shouldRemoveShadow(true)
        self.tabBarController?.tabBar.isHidden = true
        
        createFloatingButton()
        setCollectionView(localCollectionView)
        setCollectionView(ageCollectionView)
        setCollectionView(categoryCollectionView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectCollectionView(localCollectionView, localList, selectedList["localList"]!)
        selectCollectionView(ageCollectionView, ageList, selectedList["ageList"]!)
        selectCollectionView(categoryCollectionView, categoryList, selectedList["categoryList"]!)
    }
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeFloatingButton()
    }
    private var floatingButton: UIButton?
    private func createFloatingButton() {
        floatingButton = UIButton(type: .custom)
        floatingButton?.translatesAutoresizingMaskIntoConstraints = false
        floatingButton?.backgroundColor = .mainYellow
        floatingButton?.titleLabel?.font = UIFont(name: "SeoulNamsanB", size: 20)
        if isFiltered {
            floatingButton?.setTitle("필터 적용하기", for: .normal)

        } else {
            floatingButton?.setTitle("신청하기", for: .normal)
        }
        floatingButton?.addTarget(self, action: #selector(completeAction), for: .touchUpInside)
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
    func selectCollectionView(_ collectionView: UICollectionView,_ resourceList: [String], _ list: [String]){
        if list.isEmpty {
            collectionView.selectItem(at: IndexPath(row: 0, section: 0) , animated: false, scrollPosition: .centeredHorizontally)
        } else {
            for local in list {
                if let index = resourceList.index(of: local) {
                    collectionView.selectItem(at: IndexPath(row: index, section: 0), animated: false, scrollPosition: .centeredHorizontally)
                }
            }
        }
    }
    
    func setCollectionView(_ collectionView: UICollectionView){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsMultipleSelection = true
        collectionView.register(UINib(nibName: "PostingCategoryCell", bundle: nil), forCellWithReuseIdentifier: "HashTagCell")
    }
    
//    @IBAction func completeAction(_ sender: Any) {
//        checkEmptyList()
//        delegate?.saveData(data: selectedList)
//        self.navigationController?.popViewController(animated: true)
//    }
    
    @objc func completeAction() {
        checkEmptyList()
//        delegate?.saveData(data: selectedList)
        print("isFiltered??-->", isFiltered)
        if isFiltered {
            delegateF?.saveFData(data: selectedList)
        } else {
            delegate?.saveData(data: selectedList)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func checkEmptyList(){
        if selectedList["localList"]!.isEmpty {
            selectedList["localList"]?.append("서울 전체")
            localCollectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .top)
        }
        if selectedList["ageList"]!.isEmpty {
            selectedList["ageList"]?.append("나이 전체")
            ageCollectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .top)
        }
        if selectedList["categoryList"]!.isEmpty {
            selectedList["categoryList"]?.append("카테고리 전체")
            categoryCollectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .top)
        }
    }
}

extension PostingCategoryVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == localCollectionView {
            return localList.count
        } else if collectionView == ageCollectionView {
            return ageList.count
        } else {
            return categoryList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HashTagCell", for: indexPath) as! PostingCategoryCell
        if collectionView == localCollectionView {
            cell.tagLabel.text = localList[indexPath.row]
        } else if collectionView == ageCollectionView {
            cell.tagLabel.text = ageList[indexPath.row]
        } else {
            cell.tagLabel.text = categoryList[indexPath.row]
            if indexPath.row == 0 {
                cell.contentView.frame.size.width = 169
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ( collectionView.frame.width - 15 ) / 4
        var size: CGSize = CGSize(width: width, height: 28)
        if collectionView == categoryCollectionView && indexPath.row == 0 {
            size = CGSize(width: (width * 2 + 5), height: 28)
        }
        
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == localCollectionView {
            selectAction(collectionView, indexPath.row ,localList, &selectedList["localList"]!)
        } else if collectionView == ageCollectionView {
            selectAction(collectionView, indexPath.row ,ageList, &selectedList["ageList"]!)
        } else {
            selectAction(collectionView, indexPath.row ,categoryList, &selectedList["categoryList"]!)
        }
    }
    
    func selectAction(_ collectionView: UICollectionView,_ row: Int,_ resourceList: [String], _ list: inout [String]){
        if row == 0 {
            selectFirstTag(collectionView)
            list.removeAll()
        } else {
            collectionView.deselectItem(at: IndexPath(item: 0, section: 0), animated: false)
            if let index = list.index(of: resourceList[0]) {
                list.remove(at: index)
            }
        }
        list.append(resourceList[row])
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == localCollectionView {
            if let index = selectedList["localList"]?.index(of: localList[indexPath.row]) {
                selectedList["localList"]?.remove(at: index)
            }
        } else if collectionView == ageCollectionView {
            if let index = selectedList["ageList"]?.index(of: ageList[indexPath.row]) {
                selectedList["ageList"]?.remove(at: index)
            }
        } else {
            if let index = selectedList["categoryList"]?.index(of: categoryList[indexPath.row]) {
                selectedList["categoryList"]?.remove(at: index)
            }
        }
        checkEmptyList()
    }
    
    func selectFirstTag(_ cv: UICollectionView){
        cv.allowsSelection = false
        cv.allowsMultipleSelection = true
        cv.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: .centeredVertically)
    }
}

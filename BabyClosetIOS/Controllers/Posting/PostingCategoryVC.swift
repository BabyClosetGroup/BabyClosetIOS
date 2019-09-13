//
//  PostingCategoryVC.swift
//  BabyClosetIOS
//
//  Created by 박경선 on 05/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

import UIKit

protocol SaveDataDelegate:class{
    func saveData(data saveData:[String: [String]])
}
class PostingCategoryVC: UIViewController,UIViewControllerTransitioningDelegate {
    
    let localList: [String] = ["서울 전체", "강남구", "강동구", "강북구", "강서구", "관악구", "광진구", "구로구", "금천구", "노원구", "도봉구", "동대문구", "동작구", "마포구", "서대문구", "서초구", "성동구", "성북구", "송파구", "양천구", "영등포구", "용산구", "은평구", "종로구", "중구", "중랑구"]
    
    let ageList: [String] = ["나이 전체", "3개월", "12개월", "24개월", "24~30개월"]
    
    let categoryList: [String] = ["카테고리 전체", "베스트", "배내옷", "바디슈트", "내의", "슬리핑가운", "원피스", "상의", "하의", "상하복"]
    
    weak var delegate:SaveDataDelegate?
    var selectedLocalList: [String] = []
    var selectedAgeList: [String] = []
    var selectedCategoryList: [String] = []
    var selectedList: [String:[String]] = [:]
    
    @IBOutlet weak var localCollectionView: UICollectionView!
    @IBOutlet weak var ageCollectionView: UICollectionView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.shouldRemoveShadow(true)
        
        setCollectionView(localCollectionView)
        setCollectionView(ageCollectionView)
        setCollectionView(categoryCollectionView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !selectedList.isEmpty {
            checkSelectItem()
        }
        selectCollectionView(localCollectionView, selectedLocalList)
        selectCollectionView(ageCollectionView, selectedAgeList)
        selectCollectionView(categoryCollectionView, selectedCategoryList)
    }
    
    func checkSelectItem(){
        for local in selectedList["localList"]! {
            if let index = localList.index(of: local) {
                localCollectionView.selectItem(at: IndexPath(row: index, section: 0), animated: false, scrollPosition: .centeredHorizontally)
                selectedLocalList.append(localList[index])
            }
        }
        
        for age in selectedList["ageList"]! {
            if let index = ageList.index(of: age) {
                ageCollectionView.selectItem(at: IndexPath(row: index, section: 0), animated: false, scrollPosition: .centeredHorizontally)
                selectedAgeList.append(ageList[index])
            }
        }
        
        for category in selectedList["categoryList"]! {
            if let index = categoryList.index(of: category) {
                categoryCollectionView.selectItem(at: IndexPath(row: index, section: 0), animated: false, scrollPosition: .centeredHorizontally)
                selectedCategoryList.append(categoryList[index])
            }
        }
    }
    
    func selectCollectionView(_ collectionView: UICollectionView,_ list: [String]){
        if list.isEmpty {
            collectionView.selectItem(at: IndexPath(row: 0, section: 0) , animated: false, scrollPosition: .centeredHorizontally)
        }
    }
    
    func setCollectionView(_ collectionView: UICollectionView){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsMultipleSelection = true
        collectionView.register(UINib(nibName: "PostingCategoryCell", bundle: nil), forCellWithReuseIdentifier: "HashTagCell")
    }
    
    @IBAction func completeAction(_ sender: Any) {
        selectedList.removeAll()
        if selectedLocalList.isEmpty {
            selectedLocalList.append("서울 전체")
        }
        selectedList.updateValue(selectedLocalList, forKey: "localList")
        if selectedAgeList.isEmpty {
            selectedAgeList.append("나이 전체")
        }
        selectedList.updateValue(selectedAgeList, forKey: "ageList")
        if selectedCategoryList.isEmpty {
            selectedCategoryList.append("카테고리 전체")
        }
        selectedList.updateValue(selectedCategoryList, forKey: "categoryList")
        delegate?.saveData(data: selectedList)
        self.navigationController?.popViewController(animated: true)
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
//                cell.tagLabel.frame.size.width = 169
                cell.contentView.frame.size.width = 169
//                cell.tabLabelWidthC.constant = 169
            }
        }
        return cell
    }
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    //        return 10
    //    }
    //
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 15
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size: CGSize = CGSize()
        size = CGSize(width: 82, height: 28)
        if collectionView == categoryCollectionView && indexPath.row == 0 {
            size = CGSize(width: 169, height: 28)
        }
        return size
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == localCollectionView {
            if indexPath.row == 0 {
                selectFirstTag(collectionView)
                selectedLocalList.removeAll()
            } else {
                collectionView.deselectItem(at: IndexPath(item: 0, section: 0), animated: false)
            }
            selectedLocalList.append(localList[indexPath.row])
        } else if collectionView == ageCollectionView {
            if indexPath.row == 0 {
                selectFirstTag(collectionView)
                selectedAgeList.removeAll()
            } else {
                collectionView.deselectItem(at: IndexPath(item: 0, section: 0), animated: false)
            }
            selectedAgeList.append(ageList[indexPath.row])
        } else {
            if indexPath.row == 0 {
                selectFirstTag(collectionView)
                selectedCategoryList.removeAll()
            } else {
                collectionView.deselectItem(at: IndexPath(item: 0, section: 0), animated: false)
            }
            selectedCategoryList.append(categoryList[indexPath.row])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        if collectionView == localCollectionView {
            if let index = selectedLocalList.index(of: localList[indexPath.row]) {
                selectedLocalList.remove(at: index)
            }
        } else if collectionView == ageCollectionView {
            if let index = selectedAgeList.index(of: ageList[indexPath.row]) {
                selectedAgeList.remove(at: index)
            }
        } else {
            if let index = selectedCategoryList.index(of: categoryList[indexPath.row]) {
                selectedCategoryList.remove(at: index)
            }
        }
    }
    
    func selectFirstTag(_ cv: UICollectionView){
        cv.allowsSelection = false
        cv.allowsMultipleSelection = true
        cv.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: .centeredVertically)
    }
}

//
//  PostingCategoryVC.swift
//  BabyClosetIOS
//
//  Created by 박경선 on 05/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

import UIKit

class PostingCategoryVC: UIViewController,UIViewControllerTransitioningDelegate {
    
    let localList: [String] = ["서울 전체", "강남구", "강동구", "강북구", "강서구", "관악구", "광진구", "구로구", "금천구", "노원구", "도봉구", "동대문구", "동작구", "마포구", "서대문구", "서초구", "성동구", "성북구", "송파구", "양천구", "영등포구", "용산구", "은평구", "종로구", "중구", "중랑구"]
    
    let ageList: [String] = ["나이 전체", "3개월", "12개월", "24개월", "24~30개월"]
    
    let categoryList: [String] = ["카테고리 전체", "베스트", "배내옷", "바디슈트", "내의", "슬리핑가운", "원피스", "상의", "하의", "상하복"]
    
    var selectedLocalList: [String] = []
    var selectedAgeList: [String] = []
    var selectedCategoryList: [String] = []
    //    let collectionViewSpacing = 5
    
    @IBOutlet weak var localCollectionView: UICollectionView!
    @IBOutlet weak var ageCollectionView: UICollectionView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.shouldRemoveShadow(true)
        localCollectionView.delegate = self
        ageCollectionView.delegate = self
        categoryCollectionView.delegate = self
        
        localCollectionView.dataSource = self
        ageCollectionView.dataSource = self
        categoryCollectionView.dataSource = self
        
        localCollectionView.allowsMultipleSelection = true
        ageCollectionView.allowsMultipleSelection = true
        categoryCollectionView.allowsMultipleSelection = true
        
        localCollectionView.register(UINib(nibName: "PostingCategoryCell", bundle: nil), forCellWithReuseIdentifier: "HashTagCell")
        ageCollectionView.register(UINib(nibName: "PostingCategoryCell", bundle: nil), forCellWithReuseIdentifier: "HashTagCell")
        categoryCollectionView.register(UINib(nibName: "PostingCategoryCell", bundle: nil), forCellWithReuseIdentifier: "HashTagCell")
    }
    
    @IBAction func completeAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PostingMainTVC") as! PostingMainTVC
        vc.categoryList.append(contentsOf: selectedLocalList)
        vc.categoryList.append(contentsOf: selectedAgeList)
        vc.categoryList.append(contentsOf: selectedCategoryList)
        self.navigationController?.pushViewController(vc, animated: true)
//        navigationController?.popToViewController(vc, animated: <#T##Bool#>)(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
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
        }
        return cell
    }
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    //        return 10
    //    }
    //
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    //        return 0
    //    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //        let safeFrame = view.safeAreaLayoutGuide.layoutFrame
        //        let width = ( collectionView.frame.width - ( 5 * 3 ) ) / 4
        //        print(width)
        var size: CGSize = CGSize()
        //        if collectionView == categoryCollectionView {
        //            if indexPath.row == 0 {
        //                size = CGSize(width: 169, height: 28)
        //            }
        //        } else {
        size = CGSize(width: 82, height: 28)
        //        }
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
        print(indexPath)
    }
    
    func selectFirstTag(_ cv: UICollectionView){
        cv.allowsSelection = false
        cv.allowsMultipleSelection = true
        cv.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: .centeredVertically)
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
}

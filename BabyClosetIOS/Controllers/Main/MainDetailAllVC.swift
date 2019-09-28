//
//  MainDetailAllVC.swift
//  BabyClosetIOS
//
//  Created by 최리안 on 16/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

import UIKit

class MainDetailAllVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, SaveDataDelegate {
    
    @IBOutlet var categoryCollection: UICollectionView!
    @IBOutlet var newAllListCollection: UICollectionView!
    @IBOutlet var categoryHeight: NSLayoutConstraint!
    
    var isMsg: Int = 0
    var allPosts: [allPostList] = []
    var a: [allPostList] = []
    var postId: Int = 0
    var pageidx: Int = 1
    
    var localList: [String] = []
    var ageList: [String] = []
    var categoryList: [String] = []
    var selectedList: [String:[String]] = [:]
    

    let networkManager = NetworkManager()

    
    override func viewDidLoad() {
        newAllListCollection.delegate = self
        newAllListCollection.dataSource = self
        
        categoryCollection.delegate = self
        categoryCollection.dataSource = self
        
        super.viewDidLoad()
        setNavigationBar()
        getPostListNetwork()
        setMsg()
        self.tabBarController?.tabBar.isHidden = true
        
        let nibNameLast = UINib(nibName: "NewCVC", bundle: nil)
        newAllListCollection.register(nibNameLast, forCellWithReuseIdentifier: "NewCVC")
        let nibNamePage = UINib(nibName: "pageCVC", bundle: nil)
        newAllListCollection.register(nibNamePage, forCellWithReuseIdentifier: "pageCVC")
        let nibNameCategory = UINib(nibName: "CategoryCVC", bundle: nil)
        categoryCollection.register(nibNameCategory, forCellWithReuseIdentifier: "CategoryCVC")
        
        
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //createFloatingButton()
        print(categoryList)
        if categoryList.count == 0 {
            categoryHeight.constant = 0
        } else {
            self.navigationItem.title = "필터적용"
            categoryHeight.constant = 58
        }
        categoryCollection.reloadData()
        self.view.layoutIfNeeded()
    }
    
    func setMsg() {
        if isMsg == 0 {
//            msgBtn.arimage = UIImage(named: "btnLetter")
        } else {
//            msgBtn.image = UIImage(named: "btnLetterAlarm")
        }
    }
    
    func setNavigationBar() {
        self.navigationController?.navigationBar.tintColor = UIColor.gray38
        navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.shouldRemoveShadow(true)

        self.navigationItem.title = "모든상품"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.B17]
        
        let filterImg    = UIImage(named: "btnFilter")!
        let msgImg  = UIImage(named: "btnLetter")!
        
        let filterBtn = UIBarButtonItem(image: filterImg,  style: .plain, target: self, action:  #selector(goFilterView))
        let msgBtn   = UIBarButtonItem(image: msgImg,  style: .plain, target: self, action:  #selector(goMessageView))
        filterBtn.imageInsets = UIEdgeInsets(top: 0.0, left:40, bottom: 0, right: 0);

        self.navigationItem.rightBarButtonItems = [msgBtn, filterBtn]
        
    }
    @objc func goMessageView(){
        let storyboard = UIStoryboard(name: "Message", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Msg")
        navigationController?.pushViewController(vc, animated: true)
        
    }
    @objc func goFilterView(){
        let storyboard = UIStoryboard(name: "Posting", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PostingCategoryVC")
        navigationController?.pushViewController(vc, animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! PostingCategoryVC
        destination.delegate = self
        destination.selectedList["localList"] = localList
        destination.selectedList["ageList"] = ageList
        destination.selectedList["categoryList"] = categoryList
    }
    func saveData(data saveData:[String: [String]]) {
        localList = saveData["localList"]!
        ageList = saveData["ageList"]!
        categoryList = saveData["categoryList"]!
        selectedList["localList"] = localList
        selectedList["ageList"] = ageList
        selectedList["categoryList"] = categoryList
        categoryCollection.reloadData()
    }
    
    func getPostListNetwork(){
        networkManager.getAllList(page: pageidx){ [weak self] (success, error) in
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
                self?.isMsg = success?.data?.isNewMessage ?? 0
                self?.allPosts += success?.data?.allPost ?? []
                self?.newAllListCollection.reloadData()
                print("이건 메시지 알림-->", self?.isMsg)
            }
        }
    }

}

extension MainDetailAllVC {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.newAllListCollection {
            return allPosts.count+1
        } else {
            return localList.count + ageList.count + categoryList.count
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.newAllListCollection {
            let dvc = storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
            let data = allPosts[indexPath.row]
            dvc.postid = data.postIdx ?? 0
            navigationController?.pushViewController(dvc, animated: true)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.newAllListCollection {
            if allPosts.count != 0 {
                if indexPath.row == allPosts.count {
                    let cell = newAllListCollection.dequeueReusableCell(withReuseIdentifier: "pageCVC", for: indexPath) as! pageCVC
                    cell.pageBtn.addTarget(self, action: #selector(addPage(_:)), for: .touchUpInside)
                    
                    return cell
                }
                let cell = newAllListCollection.dequeueReusableCell(withReuseIdentifier: "NewCVC", for: indexPath) as! NewCVC
                
                let data = allPosts[indexPath.row]
                print("new ---> ", data, indexPath.row)
                
                cell.title.text = data.postTitle
                let cnt_ = data.areaName ?? []
                let cnt = cnt_.count
                cell.location.text = (data.areaName?[0])! + " 외 \(cnt)곳"
                cell.titleImg.image = data.mainImage?.urlToImage()
                cell.title.sizeToFit()
                cell.location.sizeToFit()
                
                return cell
            } else {
                let cell = newAllListCollection.dequeueReusableCell(withReuseIdentifier: "NewCVC", for: indexPath) as! NewCVC
                return cell
            }
        } else {
            let cell = categoryCollection.dequeueReusableCell(withReuseIdentifier: "CategoryCVC", for: indexPath) as! CategoryCVC
            if localList.count > indexPath.row {
                cell.category.setTitle(localList[indexPath.row], for: .normal)
            } else if (localList.count + ageList.count ) > indexPath.row {
                cell.category.setTitle(ageList[indexPath.row - localList.count], for: .normal)
            } else {
                let row = indexPath.row - ( localList.count + ageList.count )
                cell.category.setTitle(categoryList[row], for: .normal)
            }
            cell.isSelected = true
            return cell
        }
    }
    @objc func addPage(_ sender: Any) {
        pageidx += 1
        getPostListNetwork()
    }
    
}
extension MainDetailAllVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.newAllListCollection {
            return 15
        } else {
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.newAllListCollection {
            if indexPath.row == allPosts.count {
                return CGSize(width: 343, height: 42)

            }
            return CGSize(width: 164, height: 213)
        } else {
            return CGSize(width: 82, height: 28)
        }
    }
}

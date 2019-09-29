//
//  MainDetailDDay.swift
//  BabyClosetIOS
//
//  Created by 최리안 on 16/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

import UIKit

class MainDetailDDayVC: UIViewController, SaveDataDelegate {
    
    @IBOutlet var lastAllListCollection: UICollectionView!
    @IBOutlet var categoryCollection: UICollectionView!
    @IBOutlet var categoryHeight: NSLayoutConstraint!
    
    var isFilter = false
    var isMsg: Int = 0
    var deadlinePosts: [deadlinePostLists] = []
    var postId: Int = 0
    var pageidx: Int = 1

    var localList: [String] = []
    var ageList: [String] = []
    var categoryList: [String] = []
    var selectedList: [String:[String]] = [:]
    
    var areaStr: String = ""
    var ageStr: String = ""
    var clothStr: String = ""
    
    let networkManager = NetworkManager()
    
    private var filterBtn: UIBarButtonItem?
    private var msgBtn: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lastAllListCollection.delegate = self
        lastAllListCollection.dataSource = self
        categoryCollection.delegate = self
        categoryCollection.dataSource = self
        
        let nibNameFilter = UINib(nibName: "filterCVC", bundle: nil)
        lastAllListCollection.register(nibNameFilter, forCellWithReuseIdentifier: "filterCVC")
        let nibNameLast = UINib(nibName: "LastAllCVC", bundle: nil)
        lastAllListCollection.register(nibNameLast, forCellWithReuseIdentifier: "LastAllCVC")
        let nibNamePage = UINib(nibName: "pageCVC", bundle: nil)
        lastAllListCollection.register(nibNamePage, forCellWithReuseIdentifier: "pageCVC")
        let nibNameCategory = UINib(nibName: "CategoryCVC", bundle: nil)
        categoryCollection.register(nibNameCategory, forCellWithReuseIdentifier: "CategoryCVC")
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        print(categoryList)
        if categoryList.count == 0 {
            categoryHeight.constant = 0
        } else {
            self.navigationItem.title = "필터적용"
            isFilter = true
            categoryHeight.constant = 58
        }
        if isFilter {
            getFilteredPostListNetwork()
        } else {
            getPostListNetwork()
        }
        setNavigationBar()
        setMsg()
        
        categoryCollection.reloadData()
        self.view.layoutIfNeeded()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! PostingCategoryVC
        destination.delegate = self
        destination.selectedList["localList"] = localList
        destination.selectedList["ageList"] = ageList
        destination.selectedList["categoryList"] = categoryList
    }
    func setNavigationBar() {
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = UIColor.gray38
        navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.shouldRemoveShadow(true)
        
        self.navigationItem.title = "마감임박"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.B17]
        
        let filterImg    = UIImage(named: "btnFilter")!
        let msgImg  = UIImage(named: "btnLetter")!
        
        filterBtn = UIBarButtonItem(image: filterImg,  style: .plain, target: self, action:  #selector(goFilterView))
        msgBtn   = UIBarButtonItem(image: msgImg,  style: .plain, target: self, action:  #selector(goMessageView))
        filterBtn?.imageInsets = UIEdgeInsets(top: 0.0, left:40, bottom: 0, right: 0);
        
        self.navigationItem.rightBarButtonItems = ([msgBtn, filterBtn] as! [UIBarButtonItem])
    }
    func setMsg() {
        if isMsg == 0 {
            msgBtn?.image = UIImage(named: "btnLetter")
        } else {
            msgBtn?.image = UIImage(named: "btnLetterAlarm")
        }
    }
    
    @objc func goMessageView(){
        let storyboard = UIStoryboard(name: "Message", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Msg")
        navigationController?.pushViewController(vc, animated: true)

    }
    @objc func goFilterView(){
        let storyboard = UIStoryboard(name: "Posting", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PostingCategoryVC")
        let dvc = vc as! PostingCategoryVC
        dvc.isFiltered = true
        performSegue(withIdentifier: "goPosting", sender: nil)
    }
    func makeList2String(list: [String]) -> String {
        var str: String = ""
        for item in list {
            str = item+", "+str
        }
        return str
    }
    func getFilteredPostListNetwork() {
        areaStr = ""; ageStr = ""; clothStr = ""
        areaStr = makeList2String(list: localList)
        ageStr = makeList2String(list: ageList)
        clothStr = makeList2String(list: categoryList)
        networkManager.getFilteredDeadLineList(page: pageidx, area: areaStr, age: ageStr, cloth: clothStr){ [weak self] (success, error) in
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
                self?.deadlinePosts = success?.data?.filteredDeadlinePost ?? []
                self?.lastAllListCollection.reloadData()
            }
        }
    }
    func getFilteredPostListNetworkAdd() {
        areaStr = ""; ageStr = ""; clothStr = ""
        areaStr = makeList2String(list: localList)
        ageStr = makeList2String(list: ageList)
        clothStr = makeList2String(list: categoryList)
        networkManager.getFilteredDeadLineList(page: pageidx, area: areaStr, age: ageStr, cloth: clothStr){ [weak self] (success, error) in
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
                self?.deadlinePosts += success?.data?.filteredDeadlinePost ?? []
                self?.lastAllListCollection.reloadData()
            }
        }
    }
    func getPostListNetwork(){
        networkManager.getDeadLineList(page: pageidx){ [weak self] (success, error) in
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
                self?.deadlinePosts = success?.data?.deadlinePost ?? []
                self?.lastAllListCollection.reloadData()
            }
        }
    }
    func getPostListNetworkAdd(){
        networkManager.getDeadLineList(page: pageidx){ [weak self] (success, error) in
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
                self?.deadlinePosts += success?.data?.deadlinePost ?? []
                self?.lastAllListCollection.reloadData()
            }
        }
    }
}

extension MainDetailDDayVC : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.lastAllListCollection {
            if deadlinePosts.count != 0 {
                return deadlinePosts.count + 1
            } else  { return 1 }
        } else {
            return localList.count + ageList.count + categoryList.count
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.lastAllListCollection, deadlinePosts.count != 0 {
            let dvc = storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
            let data = deadlinePosts[indexPath.row]
            dvc.postid = data.postIdx ?? 0
            navigationController?.pushViewController(dvc, animated: true)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.lastAllListCollection {
            if deadlinePosts.count != 0 {
                if indexPath.row == deadlinePosts.count {
                    let cell = lastAllListCollection.dequeueReusableCell(withReuseIdentifier: "pageCVC", for: indexPath) as! pageCVC
                    
                    cell.pageBtn.addTarget(self, action: #selector(addPage(_:)), for: .touchUpInside)

                    return cell
                }
                let cell = lastAllListCollection.dequeueReusableCell(withReuseIdentifier: "LastAllCVC", for: indexPath) as! LastAllCVC
                let data = deadlinePosts[indexPath.row]
                print("deadline ---> ", data, indexPath.row)
                
                cell.title.text = data.postTitle
                let cnt_ = data.areaName ?? []
                let cnt = cnt_.count
                cell.dday.text = data.deadline
                cell.location.text = (data.areaName?[0])! + " 외 \(cnt)곳"
                
                cell.titleImg.image = data.mainImage?.urlToImage()

                cell.title.sizeToFit()
                cell.location.sizeToFit()
                
                return cell
            } else {
                let cell = lastAllListCollection.dequeueReusableCell(withReuseIdentifier: "LastAllCVC", for: indexPath) as! LastAllCVC
                
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
        if isFilter {
            getFilteredPostListNetworkAdd()
        } else {
            getPostListNetworkAdd()
        }
    }
}
    
extension MainDetailDDayVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.lastAllListCollection {
            return 15
        } else {
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.lastAllListCollection {
            if deadlinePosts.count == 0 {
                return CGSize(width: 343, height: 667)
            }
            if indexPath.row == deadlinePosts.count {
                return CGSize(width: 343, height: 42)
            }
            return CGSize(width: 164, height: 213)
        } else {
            return CGSize(width: 82, height: 28)
        }
    }
}


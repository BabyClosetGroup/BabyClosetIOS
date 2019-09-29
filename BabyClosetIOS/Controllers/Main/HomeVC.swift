//
//  HomeVC.swift
//
//
//  Created by 최리안 on 16/09/2019.
//

import UIKit

class HomeVC: UIViewController {
    var isMsg: Int = 0
    var deadlinePosts: [deadlinePostList] = []
    var newPosts: [recentPostList] = []
    var postId: Int = 0

    @IBOutlet var justLine: UIView!
    @IBOutlet var lastListCollection: UICollectionView!
    @IBOutlet var newListCollection: UICollectionView!
    @IBOutlet var msgBtn: UIBarButtonItem!
    
    let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lastListCollection.delegate = self
        lastListCollection.dataSource = self
        newListCollection.delegate = self
        newListCollection.dataSource = self
        
        setNavigationBar()
        getPostListNetwork()
        setMsg()
        
        let nibNameLast = UINib(nibName: "LastCVC", bundle: nil)
        lastListCollection.register(nibNameLast, forCellWithReuseIdentifier: "LastCVC")
        let nibNameNew = UINib(nibName: "NewCVC", bundle: nil)
        newListCollection.register(nibNameNew, forCellWithReuseIdentifier: "NewCVC")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "아가옷장"
//        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.B17]
        self.tabBarController?.tabBar.isHidden = false
        getPostListNetwork()        
    }
    
    func setNavigationBar() {
        self.navigationController?.navigationBar.tintColor = UIColor.gray38
        navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.shouldRemoveShadow(true)
    }
    
    func setMsg() {
        if isMsg == 0 {
            msgBtn.image = UIImage(named: "btnLetter")
        } else {
            msgBtn.image = UIImage(named: "btnLetterAlarm")
        }
    }
    
    func getPostListNetwork(){
        networkManager.getHomeList(){ [weak self] (success, error) in
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
                self?.newPosts = success?.data?.recentPost ?? []
                self?.lastListCollection.reloadData()
                self?.newListCollection.reloadData()
                print("이건 메시지 알림-->", self?.isMsg)
            }
        }
    }
    
}


extension HomeVC : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.lastListCollection {
           return deadlinePosts.count
        } else {
            return newPosts.count
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == self.lastListCollection {
            return 1
        } else {
            return 1
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.lastListCollection {
            if  deadlinePosts.count != 0 {
                let cell = lastListCollection.dequeueReusableCell(withReuseIdentifier: "LastCVC", for: indexPath) as! LastCVC
                print("indexpath", indexPath.row)
                let data = deadlinePosts[indexPath.row]
                print("daedline ---> ", data, indexPath.row)
                
                cell.title.text = data.postTitle
                let cnt_ = data.areaName ?? []
                let cnt = cnt_.count
                if let dataarea = data.areaName {
                    cell.location.text = dataarea[0] + " 외 \(cnt)곳"
                }
//                cell.location.text = (data.areaName?[0])!+" 외 \(cnt)곳"
                cell.titleImg.image = data.mainImage?.urlToImage()
                cell.dday.text = data.deadline
                cell.title.sizeToFit()
                cell.location.sizeToFit()
                self.postId = data.postIdx ?? 0

                return cell
            } else  {
                let cell = lastListCollection.dequeueReusableCell(withReuseIdentifier: "LastCVC", for: indexPath) as! LastCVC
                cell.title.text = "새로운게 없음.."
                return cell
            }
        } else {
            if newPosts.count != 0 {
                let cell = newListCollection.dequeueReusableCell(withReuseIdentifier: "NewCVC", for: indexPath) as! NewCVC
                let data = newPosts[indexPath.row]
                print("new ---> ", data, indexPath.row)
                
                cell.title.text = data.postTitle
                let cnt_ = data.areaName ?? []
                let cnt = cnt_.count
                if let dataarea = data.areaName {
                    cell.location.text = dataarea[0] + " 외 \(cnt)곳"
                }
//                cell.location.text = (data.areaName?[0])! + " 외 \(cnt)곳"
                cell.titleImg.image = data.mainImage?.urlToImage()
                cell.title.sizeToFit()
                cell.location.sizeToFit()
                self.postId = data.postIdx ?? 0

                return cell
            } else  {
                let cell = newListCollection.dequeueReusableCell(withReuseIdentifier: "NewCVC", for: indexPath) as! NewCVC
                cell.title.text = "새로운게 없음.."
                return cell
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dvc = storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
        if collectionView == self.lastListCollection {
            let data = deadlinePosts[indexPath.row]
            dvc.postid = data.postIdx ?? 0
        } else {
            let data = newPosts[indexPath.row]
            dvc.postid = data.postIdx ?? 0
        }
        navigationController?.pushViewController(dvc, animated: true)
    }
    
}
extension HomeVC: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.lastListCollection {
            return 9
        } else {
            return 15
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.lastListCollection {
            return CGSize(width: 109, height: 183)
        } else {
            return CGSize(width: 164, height: 213)
        }
    }
}

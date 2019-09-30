//
//  MyPageShareVC.swift
//  BabyClosetIOS
//
//  Created by 박경선 on 02/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

import UIKit

class MyPageShareVC: UIViewController, MyPageMenuBarDelegate {
    var myPageMenuBar = MyPageMenuBar()
    let networkManager = NetworkManager()
    var uncompleteShareList: [UncompleteShare] = []
    var completeShareList: [CompleteShare] = []
    var pageCollectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    var postIdx: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.title = "나눈 상품"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.B17]
        self.navigationController?.navigationBar.shouldRemoveShadow(true)
        
        setupMyPageMenuBar()
        setupPageCollectionView()
        getUncompletedNetwork()
        getCompletedNetwork()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        pageCollectionView.reloadData()
//    }
    
    func getUncompletedNetwork(){
        networkManager.getUncompleteShare { [weak self] (success, error) in
            if success == nil && error != nil {
                self?.simpleAlert(title: "", message: "네트워크 오류입니다.")
            }
            else if success != nil && error == nil {
                guard let stat = success?.status, stat < 300 else {
                    if let msg = success?.message {
                        self?.simpleAlert(title: "", message: msg)
                    }
                    return
                }
                self?.uncompleteShareList = success?.data?.allPost ?? []
                print(self?.uncompleteShareList)
            }
        }
    }
    
    func getCompletedNetwork(){
        networkManager.getCompleteShare { [weak self] (success, error) in
            if success == nil && error != nil {
                self?.simpleAlert(title: "", message: "네트워크 오류입니다.")
            }
            else if success != nil && error == nil {
                guard let stut = success?.status, stut < 300 else {
                    if let msg = success?.message {
                        self?.simpleAlert(title: "", message: msg)
                    }
                    return
                }
                self?.completeShareList = success?.data?.allPost ?? []
                self?.pageCollectionView.reloadData()
            }
        }
    }
    
    func setupPageCollectionView(){
        pageCollectionView.delegate = self
        pageCollectionView.dataSource = self
        pageCollectionView.backgroundColor = .gray
        pageCollectionView.showsHorizontalScrollIndicator = false
        pageCollectionView.isPagingEnabled = true
        pageCollectionView.register(UINib(nibName: "PageCell", bundle: nil), forCellWithReuseIdentifier: "PageCell")
        self.view.addSubview(pageCollectionView)
        pageCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        pageCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        pageCollectionView.heightAnchor.constraint(equalToConstant: self.view.frame.height - 88).isActive = true
        pageCollectionView.topAnchor.constraint(equalTo: self.myPageMenuBar.bottomAnchor).isActive = true
    }
    
    func setupMyPageMenuBar(){
        self.view.addSubview(myPageMenuBar)
        myPageMenuBar.delegate = self
        myPageMenuBar.translatesAutoresizingMaskIntoConstraints = false
        myPageMenuBar.indicatorViewWidthConstraint.constant = self.view.frame.width / 2
        myPageMenuBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        myPageMenuBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        myPageMenuBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        myPageMenuBar.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    func myPageMenuBar(scrollTo index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        self.pageCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}


extension MyPageShareVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PageCell", for: indexPath) as! PageCell
        if indexPath.row == 0 {
            cell.firstView = true
            cell.IncompleteData = uncompleteShareList
            cell.tableView.reloadData()
            cell.isLoading = false
            return cell
        } else {
            cell.firstView = false
            cell.CompleteData = completeShareList
            cell.tableView.reloadData()
            cell.isLoading = false
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print( "postIdx  : ", postIdx)
        if self.postIdx != nil && postIdx != -1 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyPageShareDetailVC") as! MyPageShareDetailVC
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        myPageMenuBar.indicatorViewLeadingConstraint.constant = scrollView.contentOffset.x / 2
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let itemAt = Int(targetContentOffset.pointee.x / self.view.frame.width)
        let indexPath = IndexPath(item: itemAt, section: 0)
        myPageMenuBar.myPageMenuBarCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
    }
}

extension MyPageShareVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: pageCollectionView.frame.width, height: pageCollectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}




//
//  QRListVC.swift
//  BabyClosetIOS
//
//  Created by 최리안 on 20/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

import UIKit

class QRListVC: UIViewController {

    @IBOutlet var qrListCollection: UICollectionView!
    
    let networkManager = NetworkManager()
    var allList: [allQRCodeList] = []
    override func viewDidLoad() {
        qrListCollection.delegate = self
        qrListCollection.dataSource = self
        
        super.viewDidLoad()
        

        let nibName = UINib(nibName: "QRListCVC", bundle: nil)
        qrListCollection.register(nibName, forCellWithReuseIdentifier: "QRListCVC")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        setNavigationBar()
        getQRListNetwork()
        self.view.layoutIfNeeded()
    }
    func setNavigationBar() {
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = UIColor.gray38
        navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.shouldRemoveShadow(true)
        
        self.navigationItem.title = "QR인증하기"
        
    }
    func getQRListNetwork(){
        networkManager.getQRCodeList(){ [weak self] (success, error) in
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
                self?.allList = success?.data?.allPost ?? []
                self?.qrListCollection.reloadData()
                
            }
        }
    }


}

extension QRListVC : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allList.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let dvc = storyboard?.instantiateViewController(withIdentifier: "QRShowVC") as! QRShowVC
//        let data = allList[indexPath.row]
//        dvc.postid = data.postIdx ?? 0
//        
//        navigationController?.pushViewController(dvc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = qrListCollection.dequeueReusableCell(withReuseIdentifier: "QRListCVC", for: indexPath) as! QRListCVC
        let data = allList[indexPath.row]

        cell.qrListTitle.text = data.postTitle
        
        let cnt_ = data.areaName ?? []
        let cnt = cnt_.count
        cell.qrListLocation.text = (data.areaName?[0])!+" 외 \(cnt)곳"
        
        cell.qrListImgView.image = data.mainImage?.urlToImage()
        cell.qrListTitle.sizeToFit()
        cell.qrListLocation.sizeToFit()

        cell.qrListBtn.tag = indexPath.row
        cell.qrListBtn.addTarget(self, action: #selector(goToQR(_:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func goToQR(_ sender: Any) {
        if let button = sender as? UIButton {
            let row = button.tag
            let dvc = storyboard?.instantiateViewController(withIdentifier: "QRShowVC") as! QRShowVC
            let data = allList[row]
            dvc.postid = data.postIdx ?? 0
            
            navigationController?.pushViewController(dvc, animated: true)
        }
    }
    
}
extension QRListVC: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 375, height: 149)
    }
}

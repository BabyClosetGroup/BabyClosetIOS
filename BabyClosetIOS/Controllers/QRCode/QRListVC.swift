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
    var qrTitles: [String] = ["[여아] 투피스 나눔", "3-6 개월 줄무늬 점프수트", "[여아] 투피스 나눔", "3-6 개월 줄무늬 점프수트", "[여아] 투피스 나눔", "3-6 개월 줄무늬 점프수트"]
    var qrLocations: [String] = ["중랑구","중랑구","중랑구","중랑구","중랑구","중랑구"]
    var img: UIImage = UIImage(named: "6")!
    
    override func viewDidLoad() {
        qrListCollection.delegate = self
        qrListCollection.dataSource = self
        
        super.viewDidLoad()
        
        let nibName = UINib(nibName: "QRListCVC", bundle: nil)
        qrListCollection.register(nibName, forCellWithReuseIdentifier: "QRListCVC")
    }
    


}

extension QRListVC : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return qrTitles.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = qrListCollection.dequeueReusableCell(withReuseIdentifier: "QRListCVC", for: indexPath) as! QRListCVC
        
        cell.qrListTitle.text = qrTitles[indexPath.row]
        cell.qrListLocation.text = qrLocations[indexPath.row]
        cell.qrListImgView.image = UIImage(named: "6")
        cell.qrListTitle.sizeToFit()
        cell.qrListLocation.sizeToFit()
        
        return cell
    }
    
}
extension QRListVC: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 375, height: 149)
    }
}

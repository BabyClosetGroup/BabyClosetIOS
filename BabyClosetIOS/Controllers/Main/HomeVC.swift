//
//  HomeVC.swift
//
//
//  Created by 최리안 on 16/09/2019.
//

import UIKit

class HomeVC: UIViewController {
    var titles: [String] = ["[여아] 투피스 나눔", "3-6 개월 줄무늬 점프수트", "[여아] 투피스 나눔", "3-6 개월 줄무늬 점프수트", "[여아] 투피스 나눔", "3-6 개월 줄무늬 점프수트"]
    var locations: [String] = ["중랑구","중랑구","중랑구","중랑구","중랑구","중랑구"]
    
    @IBOutlet var justLine: UIView!
    @IBOutlet var lastListCollection: UICollectionView!
    @IBOutlet var newListCollection: UICollectionView!
    override func viewDidLoad() {
        lastListCollection.delegate = self
        lastListCollection.dataSource = self
        newListCollection.delegate = self
        newListCollection.dataSource = self
        
        super.viewDidLoad()
        setNavigationBar()
        
        let nibNameLast = UINib(nibName: "LastCVC", bundle: nil)
        lastListCollection.register(nibNameLast, forCellWithReuseIdentifier: "LastCVC")
        let nibNameNew = UINib(nibName: "NewCVC", bundle: nil)
        newListCollection.register(nibNameNew, forCellWithReuseIdentifier: "NewCVC")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "아가옷장"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.B17]
        self.tabBarController?.tabBar.isHidden = false
        
    }
    
    func setNavigationBar() {
        self.navigationController?.navigationBar.tintColor = UIColor.gray38
        navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.shouldRemoveShadow(true)
    }
    
}


extension HomeVC : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.lastListCollection {
           return titles.count
        } else {
            return 4
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
            let cell = lastListCollection.dequeueReusableCell(withReuseIdentifier: "LastCVC", for: indexPath) as! LastCVC
            
            cell.title.text = titles[indexPath.row]
            cell.location.text = locations[indexPath.row]
            cell.titleImg.image = UIImage(named: "5")
            cell.title.sizeToFit()
            cell.location.sizeToFit()
            
            return cell
        } else {
            let cell = newListCollection.dequeueReusableCell(withReuseIdentifier: "NewCVC", for: indexPath) as! NewCVC
            
            cell.title.text = titles[indexPath.row]
            cell.location.text = locations[indexPath.row]
            cell.titleImg.image = UIImage(named: "2433Bd4A56987Ea437")
            cell.title.sizeToFit()
            cell.location.sizeToFit()
            
            return cell
        }
    }
    
}
extension HomeVC: UICollectionViewDelegateFlowLayout {
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    //        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    //    }
    
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

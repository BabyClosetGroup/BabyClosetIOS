//
//  MainDetailDDay.swift
//  BabyClosetIOS
//
//  Created by 최리안 on 16/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

import UIKit

class MainDetailDDayVC: UIViewController {
    var titles: [String] = ["[여아] 투피스 나눔", "3-6 개월 줄무늬 점프수트", "[여아] 투피스 나눔", "3-6 개월 줄무늬 점프수트", "[여아] 투피스 나눔", "3-6 개월 줄무늬 점프수트"]
    var locations: [String] = ["중랑구","중랑구","중랑구","중랑구","중랑구","중랑구"]
    var categorys: [String] = ["서울 전체", "강남구", "강동구", "강북구", "강서구", "관악구", "광진구", "구로구", "금천구", "노원구", "도봉구", "동대문구", "동작구", "마포구", "서대문구", "서초구", "성동구", "성북구", "송파구", "양천구"]
    var category2: [String] = []
    
    @IBOutlet var lastAllListCollection: UICollectionView!
    @IBOutlet var categoryCollection: UICollectionView!
    @IBOutlet var categoryHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        lastAllListCollection.delegate = self
        lastAllListCollection.dataSource = self
        
        categoryCollection.delegate = self
        categoryCollection.dataSource = self
        
        super.viewDidLoad()
        setNavigationBar()
        self.tabBarController?.tabBar.isHidden = true
        
        if categorys.count == 0 {
            categoryHeight.constant = 0
        }
        
        let nibNameLast = UINib(nibName: "LastAllCVC", bundle: nil)
        lastAllListCollection.register(nibNameLast, forCellWithReuseIdentifier: "LastAllCVC")
        let nibNameCategory = UINib(nibName: "CategoryCVC", bundle: nil)
        categoryCollection.register(nibNameCategory, forCellWithReuseIdentifier: "CategoryCVC")
        
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func setNavigationBar() {
        self.navigationController?.navigationBar.tintColor = UIColor.gray38
        navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.shouldRemoveShadow(true)
        
        self.navigationItem.title = "마감임박"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.B17]
        
        let filterImg    = UIImage(named: "btnFilter")!
        let msgImg  = UIImage(named: "btnLetter")!
        
        let filterBtn = UIBarButtonItem(image: filterImg,  style: .plain, target: self, action:  #selector(buttonPressed(_:)))
        filterBtn.tag = 1
        let msgBtn   = UIBarButtonItem(image: msgImg,  style: .plain, target: self, action:  #selector(buttonPressed(_:)))
        msgBtn.tag = 2
        filterBtn.imageInsets = UIEdgeInsets(top: 0.0, left:30, bottom: 0, right: 0);
//        msgBtn.imageInsets = UIEdgeInsets(top: 0.0, left: 30, bottom: 0, right: 0);
        self.navigationItem.rightBarButtonItems = [msgBtn, filterBtn]


    }
    
    @objc private func buttonPressed(_ sender: Any) {
        if let button = sender as? UIBarButtonItem {
            switch button.tag {
            case 1:
                self.view.backgroundColor = .blue
            case 2:
                // Change the background color to red.
                self.view.backgroundColor = .red
            default: print("error")
            }
        }
    }

}

extension MainDetailDDayVC : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.lastAllListCollection {
            return titles.count
        } else {
            return categorys.count
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.lastAllListCollection {
            let cell = lastAllListCollection.dequeueReusableCell(withReuseIdentifier: "LastAllCVC", for: indexPath) as! LastAllCVC
            
            cell.title.text = titles[indexPath.row]
            cell.location.text = locations[indexPath.row]
            cell.titleImg.image = UIImage(named: "2433Bd4A56987Ea437")
            cell.title.sizeToFit()
            cell.location.sizeToFit()
            
            return cell
        } else {
            let cell = categoryCollection.dequeueReusableCell(withReuseIdentifier: "CategoryCVC", for: indexPath) as! CategoryCVC
            
            cell.category.setTitle(categorys[indexPath.row], for: .normal)
            cell.category.sizeToFit()
            
            return cell
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
            return CGSize(width: 164, height: 213)
        } else {
            return CGSize(width: 82, height: 28)
        }
    }
}


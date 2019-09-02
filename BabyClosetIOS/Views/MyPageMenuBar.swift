//
//  MyPageMenuBar.swift
//  BabyClosetIOS
//
//  Created by 박경선 on 02/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//
import UIKit

protocol MyPageMenuBarDelegate: class {
    func myPageMenuBar(scrollTo index: Int)
}

class MyPageMenuBar: UIView {
    
    weak var delegate: MyPageMenuBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupMyPageMenuBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var myPageMenuBarCollectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    var indicatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.mainYellow
        return view
    }()
    
    //MARK: Properties
    var indicatorViewLeadingConstraint:NSLayoutConstraint!
    var indicatorViewWidthConstraint: NSLayoutConstraint!
    //MARK: Setup Views
    
    
    func setupCollectioView(){
        myPageMenuBarCollectionView.delegate = self
        myPageMenuBarCollectionView.dataSource = self
        myPageMenuBarCollectionView.showsHorizontalScrollIndicator = false
        myPageMenuBarCollectionView.register(UINib(nibName: "PageItemCell", bundle: nil), forCellWithReuseIdentifier: "PageItemCell")
        myPageMenuBarCollectionView.isScrollEnabled = false
        
        let indexPath = IndexPath(item: 0, section: 0)
        myPageMenuBarCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
    }
    
    func setupMyPageMenuBar(){
        setupCollectioView()
        self.addSubview(myPageMenuBarCollectionView)
        myPageMenuBarCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        myPageMenuBarCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        myPageMenuBarCollectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        myPageMenuBarCollectionView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        self.addSubview(indicatorView)
        indicatorViewWidthConstraint = indicatorView.widthAnchor.constraint(equalToConstant: self.frame.width / 2)
        indicatorViewWidthConstraint.isActive = true
        indicatorView.heightAnchor.constraint(equalToConstant: 3).isActive = true
        indicatorViewLeadingConstraint = indicatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        indicatorViewLeadingConstraint.isActive = true
        indicatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
}

//MARK:- UICollectionViewDelegate, DataSource
extension MyPageMenuBar: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PageItemCell", for: indexPath) as! PageItemCell
        if indexPath.row == 0 {
            cell.label.text = "나눔 미완료"
        } else {
            cell.label.text = "나눔 완료"
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width / 2 , height: 44)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.myPageMenuBar(scrollTo: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? PageItemCell else {return}
        cell.label.textColor = .lightGray
    }
}
//MARK:- UICollectionViewDelegateFlowLayout
extension MyPageMenuBar: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

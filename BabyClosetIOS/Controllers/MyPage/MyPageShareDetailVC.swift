//
//  MyPageShareDetailVC.swift
//  BabyClosetIOS
//
//  Created by 박경선 on 03/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

import UIKit

class MyPageShareDetailVC: UIViewController, UINavigationBarDelegate {

    @IBOutlet weak var applyCountLabel: UILabel!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var tableView: UITableView!
    
    var countApply = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 103.0
        tableView.allowsSelection = false
        
        applyCountLabel.text = "신청한 사람 (\(countApply))"
    }
    
    func setNavigationBar(){
        navBar.delegate = self
        let navItem = UINavigationItem()
        navBar.items = [navItem]
        navBar.tintColor = .gray118
        navBar.barTintColor = .white
        
        navItem.title = "신청자 목록"
        navItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "btn-back"), style: .plain, target: self, action: #selector(goBackAction))
        navBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.B17]
    }

    @objc func goBackAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectAndNoteAction(_ sender: Any) {
        tableView.allowsSelection = true
        // 대충 쪽지뷰로 넘어간다는 내용
    }
}

extension MyPageShareDetailVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countApply
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "applyListCell", for: indexPath) as! ApplyListTVC
        return cell
    }
}

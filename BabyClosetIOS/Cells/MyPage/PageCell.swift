//
//  PageCell.swift
//  BabyClosetIOS
//
//  Created by 박경선 on 02/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {
    var firstView: Bool = true
    var numberOfRows = 0
    @IBOutlet weak var tableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        tableView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        tableView.register(UINib(nibName: "IncompleteTVC", bundle: nil), forCellReuseIdentifier: "IncompleteTVC")
        tableView.register(UINib(nibName: "CompleteTVC", bundle: nil), forCellReuseIdentifier: "CompleteTVC")
        
    }
    
}

extension PageCell : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell
        if firstView {
            cell = tableView.dequeueReusableCell(withIdentifier: "IncompleteTVC", for: indexPath) as! IncompleteTVC
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "CompleteTVC", for: indexPath) as! CompleteTVC
        }
        return cell
    }
    
}

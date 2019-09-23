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
    var IncompleteData: [UncompleteShare] = []
    var CompleteData: [CompleteShare] = []
    
    @IBOutlet weak var tableView: UITableView!
    var imageView : UIImageView = UIImageView()
    
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
        if firstView {
            return IncompleteData.count
        }
        else {
            return CompleteData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if firstView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "IncompleteTVC", for: indexPath) as! IncompleteTVC
            let data = IncompleteData[indexPath.row]
            cell.title.text = data.postTitle
            
            if let area = data.areaName, area.count > 1 {
                let attributedString = NSMutableAttributedString()
                    .normal(area[0], font: UIFont.M12)
                    .normal("외 \(area.count - 1)구", font: UIFont.L12)
                cell.area.attributedText = attributedString
            } else if let area = data.areaName{
                let attributedString = NSMutableAttributedString()
                    .normal(area[0], font: UIFont.M12)
                cell.area.attributedText = attributedString
            }
            cell.postIdx = data.postIdx
            cell.register.text = data.registerNumber
            if let img = data.mainImage?.urlToImage() {
                imageView = cell.mainImage.setImgView(img: img)
                cell.addSubview(imageView)
            }
            return cell
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CompleteTVC", for: indexPath) as! CompleteTVC
            let data = CompleteData[indexPath.row]
            
            cell.title.text = data.postName
            
            if let area = data.areaName, area.count > 1 {
                let attributedString = NSMutableAttributedString()
                    .normal(area[0], font: UIFont.M12)
                    .normal("외 \(area.count - 1)구", font: UIFont.L12)
                cell.area.attributedText = attributedString
            } else if let area = data.areaName {
                let attributedString = NSMutableAttributedString()
                    .normal(area[0], font: UIFont.M12)
                cell.area.attributedText = attributedString
            }
            
            if data.receiverIsRated == 0 {
                cell.isRated.text = "미부여"
            } else {
                if let rating = data.rating {
                    cell.isRated.text = "\(rating)점"
                }
            }
            if let img = data.mainImage?.urlToImage() {
                imageView = cell.imgView.setImgView(img: img)
                cell.addSubview(imageView)
            }
            
            if let nickname = data.receiverNickname {
                cell.shareWho.text = "\(nickname)님과의 나눔"
            }
            cell.date.text = data.sharedDate
            cell.receiveIdx = data.receiverIdx
            cell.postIdx = data.postIdx
            return cell
        }
    }
}

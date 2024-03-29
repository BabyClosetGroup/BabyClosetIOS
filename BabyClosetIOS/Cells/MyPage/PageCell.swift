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
    var isLoading: Bool = true
    var postIdx: Int?
    
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
        tableView.register(UINib(nibName: "EmptyApplyCell", bundle: nil), forCellReuseIdentifier: "EmptyApplyCell")
        tableView.register(UINib(nibName: "IncompleteTVC", bundle: nil), forCellReuseIdentifier: "IncompleteTVC")
        tableView.register(UINib(nibName: "CompleteTVC", bundle: nil), forCellReuseIdentifier: "CompleteTVC")
    }
}

extension PageCell : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if firstView {
            return IncompleteData.count + 1
        }
        else {
            return CompleteData.count + 1
        }
    }
    
    @objc func go2(_ sender: Any) {
        if let button = sender as? UIButton {
            let row = button.tag
            let storyboard = UIStoryboard(name: "MyPage", bundle: nil)
            let dvc = storyboard.instantiateViewController(withIdentifier: "MyPageShareDetailVC") as! MyPageShareDetailVC
//            let data = allList[row]
//            dvc.postid = data.postIdx ?? 0
//            performSegue(withIdentifier: "goPosting", sender: nil)

        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if firstView {
            if IncompleteData.count != 0 && IncompleteData.count > indexPath.row {
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
                cell.shareBtn.addTarget(self, action: #selector(go2(_:)), for: .touchUpInside)
                if let img = data.mainImage?.urlToImage() {
                    imageView = cell.mainImage.setImgView(img: img)
                    cell.addSubview(imageView)
                }
                return cell
            } else if IncompleteData.count == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyApplyCell") as! EmptyApplyCell
                if !isLoading {
                    cell.aboveLabel.text = "아가옷장에서"
                    cell.underLabel.text = "따뜻한 나눔을 진행해보세요!"
                } else {
                    cell.aboveLabel.text = "로딩중입니다."
                    cell.underLabel.text = "잠시만 기다려주세요!"
                }
                return cell
            } else {
                return UITableViewCell()
            }
        } else {
            if CompleteData.count != 0 && CompleteData.count > indexPath.row {
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
                        cell.ratingButton.isEnabled = false
                        cell.ratingButton.backgroundColor = .gray118
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
            } else if CompleteData.count == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyApplyCell") as! EmptyApplyCell
                if !isLoading {
                    cell.aboveLabel.text = "아가옷장에서"
                    cell.underLabel.text = "따뜻한 나눔을 진행해보세요!"
                } else {
                    cell.aboveLabel.text = "로딩중입니다."
                    cell.underLabel.text = "잠시만 기다려주세요!"
                }
                return cell
            } else {
                return UITableViewCell()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if firstView {
            if IncompleteData.count != 0 && IncompleteData.count > indexPath.row{
                return 215
            } else if IncompleteData.count == 0 {
                return 695
            } else {
                return 100
            }
        }
        else {
            if CompleteData.count != 0 {
                return 215
            } else if CompleteData.count == 0 {
                return 695
            } else {
                return 100
            }
        }
    }
}

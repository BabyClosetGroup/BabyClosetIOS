//
//  SignUpTermsVC.swift
//  BabyClosetIOS
//
//  Created by 박경선 on 01/09/2019.
//  Copyright © 2019 박경선. All rights reserved.
//

import UIKit

class SignUpTermsVC: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var subContainerView: UIView!
    @IBOutlet weak var agreeAction: UIButton!
    
    var agreeToAllTerm: Bool = false
    var agreeToServiceTerm: Bool = false
    var agreeToPersonalTerm: Bool = false
    
    @IBOutlet weak var allTerm: UIButton!
    @IBOutlet weak var serviceTerm: UIButton!
    @IBOutlet weak var personalTerm: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        containerView.roundCorners(corners: [.allCorners], radius: 8)
        subContainerView.roundCorners(corners: [.topLeft, .topRight], radius: 8)
        agreeAction.roundCorners(corners: [.allCorners], radius: 8)
        containerView.backgroundColor = UIColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    @IBAction func termAction(_ sender: UIButton) {
        if sender == allTerm {
            agreeToAllTerm = !agreeToAllTerm
            agreeToServiceTerm = agreeToAllTerm
            agreeToPersonalTerm = agreeToAllTerm
        }
        else if sender == serviceTerm {
            if agreeToAllTerm && agreeToServiceTerm {
                agreeToAllTerm = !agreeToAllTerm
            }
            agreeToServiceTerm = !agreeToServiceTerm
        }
        else if sender == personalTerm {
            if agreeToAllTerm && agreeToPersonalTerm {
                agreeToAllTerm = !agreeToAllTerm
            }
            agreeToPersonalTerm = !agreeToPersonalTerm
        }
        
        if agreeToAllTerm {
            allTerm.setImage(UIImage(named: "btn-checked"), for: .normal)
        } else {
            allTerm.setImage(UIImage(named: "btn-unchecked"), for: .normal)
        }
        
        if agreeToServiceTerm {
            serviceTerm.setImage(UIImage(named: "btn-checked"), for: .normal)
        } else {
            serviceTerm.setImage(UIImage(named: "btn-unchecked"), for: .normal)
        }
        
        if agreeToPersonalTerm {
            personalTerm.setImage(UIImage(named: "btn-checked"), for: .normal)
        } else {
            personalTerm.setImage(UIImage(named: "btn-unchecked"), for: .normal)
        }
    }
    
}

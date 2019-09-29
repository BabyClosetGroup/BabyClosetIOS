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
    @IBOutlet weak var agreeButton: UIButton!
    
    @IBOutlet weak var allTerm: CheckBoxButton!
    @IBOutlet weak var serviceTerm: CheckBoxButton!
    @IBOutlet weak var personalTerm: CheckBoxButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        disableButton()
        containerView.roundCorners(corners: [.allCorners], radius: 8)
        subContainerView.roundCorners(corners: [.topLeft, .topRight], radius: 8)
        agreeButton.roundCorners(corners: [.allCorners], radius: 8)
        containerView.backgroundColor = UIColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    @IBAction func termAction(_ sender: UIButton) {
        if sender == allTerm {
            serviceTerm.isChecked = !allTerm.isChecked
            personalTerm.isChecked = !allTerm.isChecked
            allTerm.isChecked = !allTerm.isChecked
        } else if sender == serviceTerm {
            if allTerm.isChecked && serviceTerm.isChecked {
                allTerm.isChecked = false
            }
            serviceTerm.isChecked = !serviceTerm.isChecked
        } else if sender == personalTerm {
            if allTerm.isChecked && personalTerm.isChecked {
                allTerm.isChecked = false
            }
            personalTerm.isChecked = !personalTerm.isChecked
        }
        
        if serviceTerm.isChecked && personalTerm.isChecked {
            enableButton()
        } else {
            disableButton()
        }
    }
    
    func enableButton(){
        agreeButton.isEnabled = true
        agreeButton.backgroundColor = .mainYellow
    }
    
    func disableButton(){
        agreeButton.isEnabled = false
        agreeButton.backgroundColor = .gray118
    }
    
    @IBAction func agreeAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        self.present(vc, animated: true, completion: nil)
    }
    
}

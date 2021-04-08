//
//  MyPageVC.swift
//  Doldamgil
//
//  Created by Kyle Yang on 2020/09/08.
//  Copyright © 2020 Kyle Yang. All rights reserved.
//

import UIKit
import Charts

class MyPageVC: UIViewController {
    
    let topImageView = UIImageView()
    let profileImageView = UIImageView()
    let nicknameLbl = UILabel()
    let personalInfoLbl = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        setNaviBar()
        
        view.addSubview(topImageView)
        setTopImageView()
        
        view.addSubview(profileImageView)
        setProfileImageView()
        
    }
}

extension MyPageVC {
    func setNaviBar() {
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
        
        let changePersonalInfoBtn = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: nil)
        changePersonalInfoBtn.tintColor = .twilightBlue
        let changePwBtn = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: nil)
        changePwBtn.tintColor = .twilightBlue
        
        self.navigationItem.rightBarButtonItems = [changePwBtn, changePersonalInfoBtn]
    }
    
    func setTopImageView() {
        topImageView.image = UIImage(named: "topImage")
        topImageView.translatesAutoresizingMaskIntoConstraints = false
        
        topImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        topImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        topImageView.heightAnchor.constraint(equalToConstant: 236).isActive = true
    }
    
    func setProfileImageView() {
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        
        profileImageView.image = UIImage(named: "profileImg")
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.borderColor = UIColor.white.cgColor
        profileImageView.clipsToBounds = true
        profileImageView.layoutIfNeeded()

        profileImageView.topAnchor.constraint(equalTo: topImageView.topAnchor, constant: 177).isActive = true
        profileImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 127).isActive = true
        profileImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -127).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 118).isActive = true
    }
    
    func setNicknameLbl() {
        nicknameLbl.translatesAutoresizingMaskIntoConstraints = false
        
        nicknameLbl.text = "gaeng"
        
        nicknameLbl.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 5).isActive = true
    }
}

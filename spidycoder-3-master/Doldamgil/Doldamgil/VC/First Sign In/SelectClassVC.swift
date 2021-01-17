//
//  ClassSelectVC.swift
//  Doldamgil
//
//  Created by Kyle Yang on 2020/10/02.
//  Copyright © 2020 Kyle Yang. All rights reserved.
//

import UIKit

class SelectClassVC: UIViewController {
    
    let progressBar = UIProgressView()
    let newbieLevelBtn = UIButton()
    let intermediateLevelBtn = UIButton()
    let highLevelBtn = UIButton()
    let expertLevelBtn = UIButton()
    let doneBtn = UIButton()
    
    var userClass = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setNaviBar(title: "클라이밍 레벨 선택")
        
        view.addSubview(progressBar)
        setProgressBar(proView: progressBar, percent: 1)
        
        view.addSubview(newbieLevelBtn)
        setNewbieBtn()
        
        view.addSubview(intermediateLevelBtn)
        setIntermediateBtn()
        
        view.addSubview(highLevelBtn)
        setHighBtn()
        
        view.addSubview(expertLevelBtn)
        setExpertBtn()
        
        view.addSubview(doneBtn)
        setDoneBtn()
    }
}

extension SelectClassVC {
    func setNaviBar(title: String) {
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.title = title
    }
    
    func setProgressBar(proView: UIProgressView, percent: Float) {
        proView.translatesAutoresizingMaskIntoConstraints = false
        
        proView.tintColor = .twilightBlue
        proView.trackTintColor = .lightBlueGray
        proView.setProgress(0.66, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            // set progressView to 0%, with animated set to false
            proView.setProgress(percent, animated: false)
            // 10-second animation changing from 100% to 0%
            UIView.animate(withDuration: 1, delay: 0, options: [], animations: { [unowned self] in
                proView.layoutIfNeeded()
            })
        }

        
        proView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 66).isActive = true
        proView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        proView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        proView.heightAnchor.constraint(equalToConstant: 7).isActive = true
        
    }
    
    func setNewbieBtn() {
        newbieLevelBtn.translatesAutoresizingMaskIntoConstraints = false
        
        newbieLevelBtn.layer.cornerRadius = 10.0
        newbieLevelBtn.setBackgroundImage(UIImage(named: "level_newbie"), for: .normal)
        newbieLevelBtn.adjustsImageWhenHighlighted = false
        newbieLevelBtn.addTarget(self, action: #selector(classBtnTouchUpInsde(_:)), for: .touchUpInside)
        newbieLevelBtn.tag = 0

        newbieLevelBtn.titleLabel?.numberOfLines = 0
        newbieLevelBtn.titleLabel?.textAlignment = .center
        newbieLevelBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        newbieLevelBtn.setTitle("초급\nVb ~ V0", for: .normal)
        newbieLevelBtn.setTitleColor(.twilightBlue, for: .normal)
        
        
        newbieLevelBtn.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 15).isActive = true
        newbieLevelBtn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 29).isActive = true
        newbieLevelBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -29).isActive = true
        newbieLevelBtn.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func setIntermediateBtn() {
        intermediateLevelBtn.translatesAutoresizingMaskIntoConstraints = false
        
        intermediateLevelBtn.layer.cornerRadius = 10.0
        intermediateLevelBtn.adjustsImageWhenHighlighted = false
        intermediateLevelBtn.setBackgroundImage(UIImage(named: "level_intermediate"), for: .normal)
        intermediateLevelBtn.addTarget(self, action: #selector(classBtnTouchUpInsde(_:)), for: .touchUpInside)
        intermediateLevelBtn.tag = 1
        
        intermediateLevelBtn.titleLabel?.numberOfLines = 0
        intermediateLevelBtn.titleLabel?.textAlignment = .center
        intermediateLevelBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        intermediateLevelBtn.setTitle("중급\nV0 ~ V2", for: .normal)
        intermediateLevelBtn.setTitleColor(.twilightBlue, for: .normal)
        
        intermediateLevelBtn.topAnchor.constraint(equalTo: newbieLevelBtn.bottomAnchor, constant: 26).isActive = true
        intermediateLevelBtn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 29).isActive = true
        intermediateLevelBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -29).isActive = true
        intermediateLevelBtn.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func setHighBtn() {
        highLevelBtn.translatesAutoresizingMaskIntoConstraints = false
        
        highLevelBtn.layer.cornerRadius = 10.0
        highLevelBtn.setBackgroundImage(UIImage(named: "level_high"), for: .normal)
        highLevelBtn.addTarget(self, action: #selector(classBtnTouchUpInsde(_:)), for: .touchUpInside)
        highLevelBtn.adjustsImageWhenHighlighted = false
        highLevelBtn.tag = 2
        
        highLevelBtn.titleLabel?.numberOfLines = 0
        highLevelBtn.titleLabel?.textAlignment = .center
        highLevelBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        highLevelBtn.setTitle("고급\nV3 ~ V6", for: .normal)
        highLevelBtn.setTitleColor(.twilightBlue, for: .normal)
        
        highLevelBtn.topAnchor.constraint(equalTo: intermediateLevelBtn.bottomAnchor, constant: 26).isActive = true
        highLevelBtn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 29).isActive = true
        highLevelBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -29).isActive = true
        highLevelBtn.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func setExpertBtn() {
        expertLevelBtn.translatesAutoresizingMaskIntoConstraints = false
        
        expertLevelBtn.layer.cornerRadius = 10.0
        expertLevelBtn.setBackgroundImage(UIImage(named: "level_expert"), for: .normal)
        expertLevelBtn.adjustsImageWhenHighlighted = false
        expertLevelBtn.addTarget(self, action: #selector(classBtnTouchUpInsde(_:)), for: .touchUpInside)
        expertLevelBtn.tag = 3
        
        expertLevelBtn.titleLabel?.numberOfLines = 0
        expertLevelBtn.titleLabel?.textAlignment = .center
        expertLevelBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        expertLevelBtn.setTitle("전문가\nV7 ~ V16", for: .normal)
        expertLevelBtn.setTitleColor(.twilightBlue, for: .normal)
        
        
        expertLevelBtn.topAnchor.constraint(equalTo: highLevelBtn.bottomAnchor, constant: 26).isActive = true
        expertLevelBtn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 29).isActive = true
        expertLevelBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -29).isActive = true
        expertLevelBtn.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func setDoneBtn() {
        doneBtn.translatesAutoresizingMaskIntoConstraints = false
        
        doneBtn.backgroundColor = .twilightBlue
        doneBtn.setTitleColor(.white, for: .normal)
        doneBtn.setTitle("확인", for: .normal)
        doneBtn.addTarget(self, action: #selector(btnTouchUpInsde(_:)), for: .touchUpInside)
        doneBtn.layer.cornerRadius = 10
        
        doneBtn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        doneBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        doneBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -45).isActive = true
        doneBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc func btnTouchUpInsde(_ sender: UIButton) {
        print(userClass)
        
        let rootTabVC = RootTabVC()
        rootTabVC.modalPresentationStyle = .fullScreen
        self.present(rootTabVC, animated: true, completion: nil)
//        self.navigationController?.pushViewController(naviVC, animated: true)
    }
    
    @objc func classBtnTouchUpInsde(_ sender: UIButton) {
        sender.isSelected.toggle()
        switch sender.tag {
        case 0:
            if intermediateLevelBtn.isSelected {
                intermediateLevelBtn.isSelected.toggle()
            }
            if highLevelBtn.isSelected {
                highLevelBtn.isSelected.toggle()
            }
            if expertLevelBtn.isSelected {
                expertLevelBtn.isSelected.toggle()
            }
            userClass = sender.tag
        case 1:
            if newbieLevelBtn.isSelected {
                newbieLevelBtn.isSelected.toggle()
            }
            if highLevelBtn.isSelected {
                highLevelBtn.isSelected.toggle()
            }
            if expertLevelBtn.isSelected {
                expertLevelBtn.isSelected.toggle()
            }
            userClass = sender.tag
        case 2:
            if newbieLevelBtn.isSelected {
                newbieLevelBtn.isSelected.toggle()
            }
            if intermediateLevelBtn.isSelected {
                intermediateLevelBtn.isSelected.toggle()
            }
            if expertLevelBtn.isSelected {
                expertLevelBtn.isSelected.toggle()
            }
            userClass = sender.tag
        case 3:
            if newbieLevelBtn.isSelected {
                newbieLevelBtn.isSelected.toggle()
            }
            if intermediateLevelBtn.isSelected {
                intermediateLevelBtn.isSelected.toggle()
            }
            if highLevelBtn.isSelected {
                highLevelBtn.isSelected.toggle()
            }
            userClass = sender.tag
        default:
            break
        }
        sender.setBackgroundImage(UIImage(named: "selected"), for: .selected)
    }
}

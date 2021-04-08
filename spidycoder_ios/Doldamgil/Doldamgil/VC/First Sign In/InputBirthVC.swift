//
//  InputBirthVC.swift
//  Doldamgil
//
//  Created by Kyle Yang on 2020/10/16.
//  Copyright © 2020 Kyle Yang. All rights reserved.
//

import UIKit

class InputBirthVC: UIViewController {
    
    let progressBar = UIProgressView()
    let birthLbl = UILabel()
    let datePicker = UIDatePicker()
    let nextBtn = UIButton()

    var userBirth = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setNaviBar(title: "생년 월일 입력")
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        userBirth = formatter.string(from: Date())
        
        view.addSubview(progressBar)
        setProgressBar(proView: progressBar, percent: 0.33)
        
        view.addSubview(birthLbl)
        setLbl(lbl: birthLbl, text: "생년월일")
        
        view.addSubview(datePicker)
        setDatePicker(pick: datePicker)
        
        view.addSubview(nextBtn)
        setBtn(btn: nextBtn)
    }
}

extension InputBirthVC {
    func setNaviBar(title: String) {
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.title = title
        
        if #available(iOS 14.0, *) {
            self.navigationItem.backButtonTitle = ""
            self.navigationItem.backButtonDisplayMode = .minimal
        }
        else {
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
    }
    
    func setProgressBar(proView: UIProgressView, percent: Float) {
        proView.translatesAutoresizingMaskIntoConstraints = false
        
        proView.tintColor = .twilightBlue
        proView.trackTintColor = .lightBlueGray
        proView.setProgress(0, animated: true)
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
    
    func setLbl(lbl: UILabel, text: String) {
        lbl.text = text
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        lbl.textAlignment = .center
        
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 50).isActive = true
        lbl.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        lbl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 140).isActive = true
        lbl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -140).isActive = true
    }
    
    func setDatePicker(pick: UIDatePicker) {
        pick.timeZone = NSTimeZone.local
        pick.preferredDatePickerStyle = .wheels
        pick.datePickerMode = .date
        pick.backgroundColor = .systemBackground
        pick.addTarget(self, action: #selector(pickerValueChanged(_:)), for: .valueChanged)
        
        pick.translatesAutoresizingMaskIntoConstraints = false
        pick.topAnchor.constraint(equalTo: birthLbl.bottomAnchor, constant: 60).isActive = true
        pick.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 33).isActive = true
        pick.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -33).isActive = true
        pick.heightAnchor.constraint(equalToConstant: 275).isActive = true
    }
    
    @objc func pickerValueChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let selectedDate: String = dateFormatter.string(from: sender.date)
        print(selectedDate)
        userBirth = selectedDate
    }
    
    func setBtn(btn: UIButton) {
        btn.backgroundColor = .twilightBlue
        
        btn.setTitle("다음", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(btnTouchUpInsde(_:)), for: .touchUpInside)
        btn.layer.cornerRadius = 10
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        btn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -45).isActive = true
    }
    
    @objc func btnTouchUpInsde(_ sender: UIButton) {
        print(userBirth)
        
        
        let vc = InputInfoVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}



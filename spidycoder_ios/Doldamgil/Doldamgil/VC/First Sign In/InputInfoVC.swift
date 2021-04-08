//
//  HeightInputVC.swift
//  Doldamgil
//
//  Created by Kyle Yang on 2020/10/02.
//  Copyright © 2020 Kyle Yang. All rights reserved.
//

import UIKit

class InputInfoVC: UIViewController {
    
    let progressBar = UIProgressView()
    let segCtl = UISegmentedControl(items: ["키", "몸무게"])
    let infoLbl = UILabel()
    let pickerView = UIPickerView()
    let nextBtn = UIButton()
    
    var height = 100
    var heightArray = [String]()
    
    var weight = 30
    var weightArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setNaviBar(title: "신체 정보 입력")
        
        for i in 100...220 {
            let value = String(i) + " cm"
            heightArray.append(value)
        }
        
        for i in 30...120 {
            let value = String(i) + " kg"
            weightArray.append(value)
        }
        
        view.addSubview(progressBar)
        setProgressBar(proView: progressBar, percent: 0.66)
        
        view.addSubview(infoLbl)
        setLbl(lbl: infoLbl, text: "신체 정보")
        
        view.addSubview(segCtl)
        setSegmentControl(seg: segCtl)
        
        pickerView.delegate = self
        pickerView.dataSource = self
        view.addSubview(pickerView)
        setPickerView()
        
        view.addSubview(nextBtn)
        setBtn(btn: nextBtn)
        
        
    }
}

extension InputInfoVC {
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
        proView.setProgress(0.33, animated: true)
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
    
    func setSegmentControl(seg: UISegmentedControl) {
        seg.selectedSegmentTintColor = .twilightBlue
        seg.backgroundColor = .lightGray
        seg.selectedSegmentIndex = 0
        seg.addTarget(self, action: #selector(segCtlValueChanged(_:)), for: .valueChanged)
        
        seg.translatesAutoresizingMaskIntoConstraints = false
        
        seg.topAnchor.constraint(equalTo: infoLbl.bottomAnchor, constant: 40).isActive = true
        seg.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        seg.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        seg.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    @objc func segCtlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print("키")
            self.pickerView.reloadComponent(0)
        case 1:
            print("몸무게")
            self.pickerView.reloadComponent(0)
        default:
            break
        }
    }
    
    func setPickerView() {
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.topAnchor.constraint(equalTo: segCtl.bottomAnchor, constant: 15).isActive = true
        pickerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        pickerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        pickerView.heightAnchor.constraint(equalToConstant: 250).isActive = true
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
        print(height, weight)
        
        let vc = SelectClassVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension InputInfoVC: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch segCtl.selectedSegmentIndex {
        case 0:
            let tmp = heightArray[row].components(separatedBy: " ")
            height = Int(tmp[0])!
            print(height)
        case 1:
            let tmp = weightArray[row].components(separatedBy: " ")
            weight = Int(tmp[0])!
            print(weight)
        default:
            let tmp = heightArray[row].components(separatedBy: " ")
            height = Int(tmp[0])!
            print(height)
        }
    }
}

extension InputInfoVC: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch segCtl.selectedSegmentIndex {
        case 0:
            return heightArray.count
        case 1:
            return weightArray.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch segCtl.selectedSegmentIndex {
        case 0:
            return heightArray[row]
        case 1:
            return weightArray[row]
        default:
            return heightArray[row]
        }
    }
}

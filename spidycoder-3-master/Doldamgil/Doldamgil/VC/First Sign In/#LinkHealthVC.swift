//
//  AppleHealthLink.swift
//  Doldamgil
//
//  Created by Kyle Yang on 2020/10/02.
//  Copyright © 2020 Kyle Yang. All rights reserved.
//

//import UIKit
//import HealthKit
//
//class LinkHealthVC: UIViewController {
//    
//    fileprivate var healthKitManager =  HealthKitManager()
//    
//    let progressBar = UIProgressView()
//    let appleHealthLbl = UILabel()
//    let healthSwitch = UISwitch()
//    let nextBtn = UIButton()
//    
//    lazy var healthStore = HKHealthStore()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        view.backgroundColor = .systemBackground
//        setNaviBar(title: "애플 건강 연동")
//        
//        view.addSubview(progressBar)
//        setProgressBar(proView: progressBar, percent: 0.25)
//        
//        view.addSubview(appleHealthLbl)
//        setLbl(lbl: appleHealthLbl, text: "애플 건강")
//        
//        view.addSubview(healthSwitch)
//        setSwitch(swi: healthSwitch)
//        
//        view.addSubview(nextBtn)
//        setBtn(btn: nextBtn)
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        for subview in (self.navigationController?.navigationBar.subviews)! {
//            if NSStringFromClass(subview.classForCoder).contains("BarBackground") {
//                var subViewFrame: CGRect = subview.frame
//                // subViewFrame.origin.y = -20;
//                subViewFrame.size.height = 100
//                subview.frame = subViewFrame
//            }
//            
//        }
//    }
//}
//
//extension LinkHealthVC {
//    func setNaviBar(title: String) {
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.isTranslucent = false
//        self.navigationItem.title = title
//        
//        if #available(iOS 14.0, *) {
//            self.navigationItem.backButtonTitle = ""
//            self.navigationItem.backButtonDisplayMode = .minimal
//        }
//        else {
//            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//        }
//    }
//    
//    func setProgressBar(proView: UIProgressView, percent: Float) {
//        proView.translatesAutoresizingMaskIntoConstraints = false
//        
//        proView.tintColor = .twilightBlue
//        proView.trackTintColor = .lightBlueGray
//        //        proView.setProgress(percent, animated: true)
//        //        proView.progress = percent
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//            // set progressView to 0%, with animated set to false
//            proView.setProgress(percent, animated: false)
//            // 10-second animation changing from 100% to 0%
//            UIView.animate(withDuration: 1, delay: 0, options: [], animations: { [unowned self] in
//                proView.layoutIfNeeded()
//            })
//        }
//        
//        proView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 66).isActive = true
//        proView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
//        proView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
//        proView.heightAnchor.constraint(equalToConstant: 7).isActive = true
//    }
//    
//    func setLbl(lbl: UILabel, text: String) {
//        lbl.text = text
//        lbl.font = UIFont.boldSystemFont(ofSize: 20)
//        lbl.textAlignment = .center
//        
//        lbl.translatesAutoresizingMaskIntoConstraints = false
//        
//        lbl.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 93).isActive = true
//        lbl.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
//        lbl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 140).isActive = true
//        lbl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -140).isActive = true
//    }
//    
//    func setSwitch(swi: UISwitch) {
//        swi.onTintColor = .twilightBlue
//        swi.isOn = false
//        swi.addTarget(self, action: #selector(onClickSwitch(sender:)), for: .valueChanged)
//        
//        swi.translatesAutoresizingMaskIntoConstraints = false
//        swi.topAnchor.constraint(equalTo: appleHealthLbl.bottomAnchor, constant: 150).isActive = true
//        swi.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//    }
//    
//    @objc func onClickSwitch(sender: UISwitch) {
//        if sender.isOn {
//            guard HKHealthStore.isHealthDataAvailable() else {
//                return
//            }
//            
//            let healthKitTypes: Set<HKSampleType> = [HKObjectType.quantityType(forIdentifier: .height)!, HKObjectType.quantityType(forIdentifier: .bodyMass)!]
//            
//            healthStore.requestAuthorization(toShare: nil, read: healthKitTypes) { (success, error) -> Void in
//                if let error = error {
//                    print(error.localizedDescription)
//                }
//                else {
//                    self.getHeight()
//                }
//            }
//        }
//        else {
//            !HKHealthStore.isHealthDataAvailable()
//        }
//    }
//    
//    func getHeight() {
//        let heightQunatityType = HKQuantityType.quantityType(forIdentifier: .height)
//        
//        
//    }
//    
//    func setBtn(btn: UIButton) {
//        btn.backgroundColor = .twilightBlue
//        
//        btn.setTitle("다음", for: .normal)
//        btn.setTitleColor(.white, for: .normal)
//        btn.addTarget(self, action: #selector(btnTouchUpInsde(_:)), for: .touchUpInside)
//        btn.layer.cornerRadius = 10
//        
//        btn.translatesAutoresizingMaskIntoConstraints = false
//        
//        btn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
//        btn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
//        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        btn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -45).isActive = true
//    }
//    
//    @objc func btnTouchUpInsde(_ sender: UIButton) {
//        let vc = InputBirthVC()
//        
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
//}
//
//
//

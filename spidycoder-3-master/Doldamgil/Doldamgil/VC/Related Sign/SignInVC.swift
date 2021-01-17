//
//  SignInVC.swift
//  Doldamgil
//
//  Created by Kyle Yang on 2020/10/16.
//  Copyright © 2020 Kyle Yang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SignInVC: UIViewController {
    let emailInput = UITextField()
    let pwInput = UITextField()
    let warningLbl = UILabel()
    let doneBtn = UIButton()
    let findPwBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setNaviBar(title: "로그인")
        
        view.addSubview(emailInput)
        setEmailInput()
        
        view.addSubview(pwInput)
        setPwInput()
        
        view.addSubview(warningLbl)
        setWarningLbl()
        
        view.addSubview(doneBtn)
        setDoneBtn()
        
        view.addSubview(findPwBtn)
        setFindPWBtn()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        emailInput.underlined()
        pwInput.underlined()
        pwInput.addEyesBtn()
    }
}

extension SignInVC {
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
    
    func setEmailInput() {
        emailInput.placeholder = "Email"
        emailInput.textContentType = .emailAddress
        emailInput.autocapitalizationType = .none
        emailInput.keyboardType = .emailAddress
        
        //        emailInput.underlined()
        
        emailInput.translatesAutoresizingMaskIntoConstraints = false
        
        emailInput.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60).isActive = true
        emailInput.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        emailInput.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        emailInput.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    func setPwInput() {
        pwInput.placeholder = "Password(8 ~ 16자)"
        pwInput.isSecureTextEntry = true
        
        pwInput.translatesAutoresizingMaskIntoConstraints = false
        pwInput.topAnchor.constraint(equalTo: emailInput.bottomAnchor, constant: 34).isActive = true
        pwInput.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        pwInput.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        pwInput.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    func setWarningLbl() {
        warningLbl.text = ""
        warningLbl.textColor = .systemRed
        warningLbl.textAlignment = .center
        warningLbl.font = UIFont.systemFont(ofSize: 13)
        
        warningLbl.translatesAutoresizingMaskIntoConstraints = false
        warningLbl.topAnchor.constraint(equalTo: pwInput.bottomAnchor, constant: 20).isActive = true
        warningLbl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 94).isActive = true
        warningLbl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -94).isActive = true
        warningLbl.heightAnchor.constraint(equalToConstant: 21).isActive = true
    }
    
    func setDoneBtn() {
        doneBtn.backgroundColor = .twilightBlue
        doneBtn.layer.cornerRadius = 10.0
        
        doneBtn.setTitle("로그인", for: .normal)
        doneBtn.setTitleColor(.white, for: .normal)
        doneBtn.addTarget(self, action: #selector(doneBtnTouchUpInsdoe(_:)), for: .touchUpInside)
        
        doneBtn.translatesAutoresizingMaskIntoConstraints = false
        doneBtn.topAnchor.constraint(equalTo: warningLbl.bottomAnchor, constant: 101).isActive = true
        doneBtn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 27).isActive = true
        doneBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -27).isActive = true
        doneBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc func doneBtnTouchUpInsdoe(_ sender: UIButton) {
        guard let email = emailInput.text, email.isEmpty == false else {
            self.showAlert(message: "이메일을 입력해주세요.", control: self.emailInput)
            return
        }
        
        guard let pw = pwInput.text, pw.count >= 8 || pw.count <= 16 ,pw.isEmpty == false else {
            self.showAlert(message: "패스워드를 입력해주세요.", control: self.pwInput)
            return
        }
        
        
        UserDefaults.standard.setValue(email, forKey: "email")
        UserDefaults.standard.setValue(pw, forKey: "pw")
        
        signIn(email: email, pw: pw)
        
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore  {
            print("Not first launch.")
        } else {
            print("First launch, setting UserDefault.")
            UserDefaults.standard.set(true, forKey: "launchedBefore")
        }
        
        let launched = UserDefaults.isFirstLaunch()
        if launched == true {
            let firstVC = InputBirthVC()
            let naviVC = UINavigationController(rootViewController: firstVC)
            naviVC.modalPresentationStyle = .fullScreen
            self.present(naviVC, animated: true, completion: nil)
        }
        else {
            let mainVC = RootTabVC()
            mainVC.modalPresentationStyle = .fullScreen
            
            self.present(mainVC, animated: true, completion: nil)
        }
        
    }
    
    func setFindPWBtn() {
        findPwBtn.setTitle("비밀번호를 잊어버리셨나요?", for: .normal)
        findPwBtn.setTitleColor(.darkGray, for: .normal)
        findPwBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        findPwBtn.addTarget(self, action: #selector(findPwBtnTouchUpInside(_:)), for: .touchUpInside)
        
        findPwBtn.translatesAutoresizingMaskIntoConstraints = false
        findPwBtn.topAnchor.constraint(equalTo: doneBtn.bottomAnchor, constant: 22).isActive = true
        findPwBtn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = true
        findPwBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50).isActive = true
        findPwBtn.heightAnchor.constraint(equalToConstant: 21).isActive = true
        
    }
    
    @objc func findPwBtnTouchUpInside(_ sender: UIButton) {
        let vc = FindPwVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func showAlert(message: String, control toBeFirstResponder: UIControl?){
        
        let alert: UIAlertController = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        let okAction: UIAlertAction = UIAlertAction(title: "입력하기", style: .default){ [weak toBeFirstResponder]
            (action: UIAlertAction) in toBeFirstResponder?.becomeFirstResponder()
        }
        let cancelAction: UIAlertAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true){
            print("얼럿 화면에 보여짐")
        }
    }
}

// MARK: - Network 기능 구현
extension SignInVC {
    func signIn(email: String, pw: String) {
        // "https://test.rest.doldamgil.spidycoder.com:4430//login?  username=test@test.com&password=testtesttest"
        let param = "username=\(email)&password=\(pw)"
        let finalUrl = signInUrl + param
        print(finalUrl)
        
        guard let url = URL(string: finalUrl) else {
            return
        }
        
        AF.request(url, method: .post)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    print(value)
                    let firstVC = InputBirthVC()
                    let naviVC = UINavigationController(rootViewController: firstVC)
                    naviVC.modalPresentationStyle = .fullScreen
                    self.present(naviVC, animated: true, completion: nil)
                case .failure(let error):
                    print(error)
                    self.warningLbl.text = "이메일 / 비밀번호를 확인해주세요."
                }
                
            }
        
    }
}


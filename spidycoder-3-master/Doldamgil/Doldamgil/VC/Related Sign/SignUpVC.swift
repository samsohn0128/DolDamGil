//
//  SignUpVC.swift
//  Doldamgil
//
//  Created by Kyle Yang on 2020/10/16.
//  Copyright © 2020 Kyle Yang. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {
    let nicknameTxtField = UITextField()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
//    let agreeCheckBox = CheckBox()
    let doneBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setNaviBar(title: "회원 가입")
        
        view.addSubview(nicknameTxtField)
        setNickTF()
        
        view.addSubview(emailTextField)
        setEmailTF()
        
        view.addSubview(passwordTextField)
        setPWTF()
        
        view.addSubview(doneBtn)
        setDoneBtn()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        nicknameTxtField.underlined()
        emailTextField.underlined()
        passwordTextField.underlined()
        passwordTextField.addEyesBtn()
    }
}

extension SignUpVC {
    func setNaviBar(title: String) {
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.title = title
    }
    
    func setNickTF() {
        nicknameTxtField.placeholder = "Nickname"
        
        nicknameTxtField.translatesAutoresizingMaskIntoConstraints = false
        nicknameTxtField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60).isActive = true
        nicknameTxtField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        nicknameTxtField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        nicknameTxtField.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    func setEmailTF() {
        emailTextField.placeholder = "Email"
        emailTextField.keyboardType = .emailAddress
        
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.topAnchor.constraint(equalTo: nicknameTxtField.bottomAnchor, constant: 30).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    func setPWTF() {
        passwordTextField.placeholder = "Password (8 ~ 16자)"
        passwordTextField.isSecureTextEntry = true
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 30).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    func setDoneBtn() {
        
        doneBtn.setTitle("완료", for: .normal)
        doneBtn.setTitleColor(.white, for: .normal)
        doneBtn.backgroundColor = .twilightBlue
        doneBtn.layer.cornerRadius = 10
        doneBtn.addTarget(self, action: #selector(doneBtnTouchUpInsde(_:)), for: .touchUpInside)
        
        doneBtn.translatesAutoresizingMaskIntoConstraints = false
        
        doneBtn.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 138).isActive = true
        doneBtn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 31).isActive = true
        doneBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -31).isActive = true
        doneBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}

// MARK: - Etc Func
extension SignUpVC {
    @objc func doneBtnTouchUpInsde(_ sender: UIButton) {
        guard let nickname = nicknameTxtField.text, nickname.isEmpty == false else {
            self.showAlert(message: "닉네임을 입력해주세요.", control: self.nicknameTxtField)
            return
        }
        
        guard let email = emailTextField.text, email.isEmpty == false else {
            self.showAlert(message: "이메일을 입력해주세요.", control: self.emailTextField)
            return
        }
        
        guard let pw = passwordTextField.text, pw.count >= 8 || pw.count <= 16, pw.isEmpty == false else {
            self.showAlert(message: "패스워드를 입력해주세요.", control: self.passwordTextField)
            return
        }
        
        showCongretAlert()
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
    
    func showCongretAlert() {
        let congretAlert = UIAlertController(title: "가입을 축하드립니다!", message: "가입하신 정보로 로그인을 해주세요", preferredStyle: .alert)
        // 여기 핸들러에 SignInVC로 넘어가는 기능 구현이 가능한지?
        let okAction = UIAlertAction(title: "확인", style: .default) { (action) in
            self.navigationController?.popViewController(animated: true)
        }
        
        congretAlert.addAction(okAction)
        
        self.present(congretAlert, animated: true, completion: nil)
    }
}

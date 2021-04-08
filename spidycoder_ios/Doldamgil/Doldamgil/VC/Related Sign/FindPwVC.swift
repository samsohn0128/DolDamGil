//
//  FindPwVC.swift
//  Doldamgil
//
//  Created by Kyle Yang on 2020/10/16.
//  Copyright © 2020 Kyle Yang. All rights reserved.
//

import UIKit

class FindPwVC: UIViewController {
    let nicknameTextField = UITextField()
    let emailTextField = UITextField()
    let doneBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setNaviBar(title: "비밀번호 찾기")
        
        view.addSubview(nicknameTextField)
        setNicknameTF()
        view.addSubview(emailTextField)
        setEmailTF()
        view.addSubview(doneBtn)
        setDoneBtn()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        nicknameTextField.underlined()
        emailTextField.underlined()
    }
}

// MARK: - AutoLayout
extension FindPwVC {
    func setNaviBar(title: String) {
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.title = title
    }

    
    func setNicknameTF() {
        nicknameTextField.placeholder = "Nickname"
        
        nicknameTextField.translatesAutoresizingMaskIntoConstraints = false
        nicknameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60).isActive = true
        nicknameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        nicknameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        nicknameTextField.heightAnchor.constraint(equalToConstant: 33).isActive = true
    }
    
    func setEmailTF() {
        emailTextField.placeholder = "Email"
        emailTextField.keyboardType = .emailAddress
        
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.topAnchor.constraint(equalTo: nicknameTextField.bottomAnchor, constant: 34).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 33).isActive = true
        
    }
    
    func setDoneBtn() {
        doneBtn.setTitle("확인", for: .normal)
        doneBtn.backgroundColor = .twilightBlue
        doneBtn.layer.cornerRadius = 10
        doneBtn.addTarget(self, action: #selector(doneBtnTouchUpInside(_:)), for: .touchUpInside)
        
        
        doneBtn.translatesAutoresizingMaskIntoConstraints = false
        doneBtn.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 94).isActive = true
        doneBtn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        doneBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        doneBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}

// MARK: - etc func
extension FindPwVC {
    // MARK: - 이메일 확인 후 임시 비밀번호 생성 후 이메일로 전송
    @objc func doneBtnTouchUpInside(_ sender: UIButton) {
        guard let nickname = nicknameTextField.text else { return }
        guard let email = emailTextField.text else { return }
        
        showAlert()
        
        self.dismiss(animated: true, completion: nil)
    }
    
    // 전송 후 확인 알럿 띄워주고 로그인 화면으로 이동(pop)
    func showAlert() {
        let sendMailAlert = UIAlertController(title: "임시 비밀번호 전송", message: "이메일로 임시 비밀번호를 전송해드렸습니다.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default) { (action) in
            self.navigationController?.popViewController(animated: true)
        }
        sendMailAlert.addAction(okAction)
        
        self.present(sendMailAlert, animated: true, completion: nil)
    }
}

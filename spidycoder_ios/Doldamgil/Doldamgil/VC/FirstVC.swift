//
//  FirstVC.swift
//  Doldamgil
//
//  Created by Kyle Yang on 2020/10/16.
//  Copyright © 2020 Kyle Yang. All rights reserved.
//

import UIKit

class FirstVC: UIViewController {
    let imgView = UIImageView()
    let signInBtn = UIButton()
    let signUpBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(imgView)
        setImgView()
        
        view.addSubview(signInBtn)
        setSignInBtn()
        
        view.addSubview(signUpBtn)
        setSignUpBtn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
        
        if #available(iOS 14.0, *) {
            self.navigationItem.backButtonTitle = ""
            self.navigationItem.backButtonDisplayMode = .minimal
        }
        else {
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
//        decreaseImgView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

}

extension FirstVC {
    func setImgView() {
        imgView.image = UIImage(named: "firstImg")
        
        imgView.contentMode = .scaleAspectFit
        imgView.translatesAutoresizingMaskIntoConstraints = false
        
        imgView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        imgView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        imgView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        imgView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150).isActive = true
    }
    
//    func decreaseImgView() {
//        UIView.animate(withDuration: 21.0, animations: {() -> Void in
//            self.imgView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
//            self.imgView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
//            self.imgView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
//            self.imgView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -150).isActive = true
//        }, completion: nil)
//    }
    
    func setSignInBtn() {
        signInBtn.backgroundColor = .twilightBlue
        signInBtn.setTitle("Sign In", for: .normal)
        signInBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        signInBtn.addTarget(self, action: #selector(signInBtnTouchUpInside(_:)), for: .touchUpInside)
        
        signInBtn.translatesAutoresizingMaskIntoConstraints = false
        signInBtn.topAnchor.constraint(equalTo: imgView.bottomAnchor, constant: 0).isActive = true
        signInBtn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        signInBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        signInBtn.heightAnchor.constraint(equalToConstant: 75).isActive = true
    }
    
    @objc func signInBtnTouchUpInside(_ sender: UIButton) {
        let inVC = SignInVC()
        
        self.navigationController?.pushViewController(inVC, animated: true)
    }
    
    func setSignUpBtn() {
        signUpBtn.backgroundColor = .lightGrayBlue
        signUpBtn.setTitle("Sign Up", for: .normal)
        signUpBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        signUpBtn.addTarget(self, action: #selector(signUpBtnTouchUpInside(_:)), for: .touchUpInside)
        
        signUpBtn.translatesAutoresizingMaskIntoConstraints = false
        signUpBtn.topAnchor.constraint(equalTo: signInBtn.bottomAnchor, constant: 0).isActive = true
        signUpBtn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        signUpBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        signUpBtn.heightAnchor.constraint(equalToConstant: 75).isActive = true
    }
    
    @objc func signUpBtnTouchUpInside(_ sender: UIButton) {
        let upVC = SignUpVC()
        
        self.navigationController?.pushViewController(upVC, animated: true)
    }
}

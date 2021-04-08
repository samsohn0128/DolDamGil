//
//  UITextField+Addtions.swift
//  Doldamgil
//
//  Created by Kyle Yang on 2020/10/16.
//  Copyright © 2020 Kyle Yang. All rights reserved.
//
import UIKit

extension UITextField {
    func underlined(){
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.lightGray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
    func addEyesBtn() {
        let btn = UIButton()
        btn.setImage(UIImage(named: "eyes"), for: .normal)
        btn.frame = CGRect(x: 0, y: 0, width: 23, height: 18)
        btn.addTarget(self, action: #selector(eyesBtnToggle(_:)), for: .touchUpInside)
        self.rightView = btn
        self.rightViewMode = .always
    }
    
    @objc func eyesBtnToggle(_ sender: UIButton) {
        self.isSecureTextEntry.toggle()
    }
}

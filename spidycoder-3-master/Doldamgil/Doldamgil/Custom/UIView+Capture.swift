//
//  UIView+Capture.swift
//  Doldamgil
//
//  Created by Kyle Yang on 2020/10/22.
//  Copyright © 2020 Kyle Yang. All rights reserved.
//
import UIKit

extension UIView {
    /**
     현재 뷰에 대한 화면 캡쳐
     
     - Parameter color: 라인 색상
     - Returns: 캡쳐된 화면 이미지 뷰
     */
    func capture(_ shadow: Bool = false) -> UIView {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let snapshotImageView = UIImageView(image: image)
        if shadow  {
            snapshotImageView.layer.masksToBounds = false
            snapshotImageView.layer.cornerRadius = 0.0
            snapshotImageView.layer.shadowOffset = CGSize(width: -0.5, height: 0.0)
            snapshotImageView.layer.shadowRadius = 5.0
            snapshotImageView.layer.shadowOpacity = 0.4
        }
        
        return snapshotImageView
    }
}

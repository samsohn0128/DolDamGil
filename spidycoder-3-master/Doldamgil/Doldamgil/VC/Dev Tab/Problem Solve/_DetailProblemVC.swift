//
//  DetailProblemListVC.swift
//  Doldamgil
//
//  Created by Kyle Yang on 2020/09/21.
//  Copyright © 2020 Kyle Yang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class DetailProblemLVC: UIViewController {
    let problemImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setUpImageView()
        
        let patch1Button = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(patch1))
        let patch2Button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(patch2))
        
        self.navigationItem.rightBarButtonItems = [patch1Button, patch2Button]
        

        // Do any additional setup after loading the view.
    }
    
    private func setUpImageView() {
        view.addSubview(problemImageView)
        problemImageView.translatesAutoresizingMaskIntoConstraints = false
        
        problemImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        problemImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        problemImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        problemImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    @objc private func patch1() {
        let url = "https://test.rest.doldamgil.spidycoder.com/gyms/1/edges/1/walls/2020-08-10T18:19:29Z/routes/1/2020-08-19T07:26:13Z/records"
        
        let headers: HTTPHeaders = [
          "Doldamgil-Record-Climber-Id": "1",
          "Accept": "*/*"
        ]
        
        guard let uri = URL(string: url) else {
            return
        }
        let request = AF.request(uri, method: .patch, headers: headers)
        request.responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
            default:
                return
            }
        }
    }
    
    @objc private func patch2() {
        let url = "https://test.rest.doldamgil.spidycoder.com/gyms/1/edges/1/walls/2020-08-10T18:19:29Z/routes/2/2020-08-19T07:26:13Z/records"
        
        let headers: HTTPHeaders = [
          "Doldamgil-Record-Climber-Id": "1",
          "Accept": "*/*"
        ]
        
        guard let uri = URL(string: url) else {
            return
        }
        let request = AF.request(uri, method: .patch, headers: headers)
        request.responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
            default:
                return
            }
        }
    }
}

//
//  ProblemDetailVC.swift
//  Doldamgil
//
//  Created by Kyle Yang on 2020/10/27.
//  Copyright © 2020 Kyle Yang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ProblemDetailVC: UIViewController {
    
    let problemImgView = UIImageView()
    let startBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setNaviBar(title: "문제 1")
        
        view.addSubview(problemImgView)
        setProblemImgView()
        
        view.addSubview(startBtn)
        setStartBtn()
    }
}

extension ProblemDetailVC {
    func setNaviBar(title: String) {
        self.navigationItem.title = title
        if self.traitCollection.userInterfaceStyle == .light {
            self.navigationController?.navigationBar.tintColor = .twilightBlue
        }
        else {
            self.navigationController?.navigationBar.tintColor = .white
            self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        }
        
        if #available(iOS 14.0, *) {
            self.navigationItem.backButtonTitle = ""
            self.navigationItem.backButtonDisplayMode = .minimal
        }
        else {
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
    }
    
    func setProblemImgView() {
         problemImgView.downloaded(from: "https://s3.ap-northeast-2.amazonaws.com/s3.doldamgil.spidycoder.com/gyms/1/edges/1/walls/2020-11-17T02%3A27%3A51Z/background.jpg")
        
        problemImgView.translatesAutoresizingMaskIntoConstraints = false
        
        problemImgView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        problemImgView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        problemImgView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        problemImgView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func setStartBtn() {
        startBtn.setBackgroundColor(color: .twilightBlue, forState: .normal)
        startBtn.setTitle("시작", for: .normal)
        startBtn.layer.cornerRadius = 10
        startBtn.addTarget(self, action: #selector(patch1), for: .touchUpInside)
        
        startBtn.translatesAutoresizingMaskIntoConstraints = false
        
        startBtn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        startBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        startBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        startBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "문제 출력 중", message: "벽에 선택하신 문제가 출력됩니다!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "돌아가기", style: .default, handler: { (action) in
            self.navigationController?.popViewController(animated: true)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - Network Func
extension ProblemDetailVC {
    @objc private func patch1() {
        let url = "https://test.rest.doldamgil.spidycoder.com:4430/gyms/1/edges/1/walls/2020-11-09T03%3A30%3A45Z/routes/1/2020-11-09T03%3A40%3A12Z/records"
        

        
//        showAlert()
        lastWallCretTime(urlStr: getProblemUrl, vc: self)
    }

    func lastWallCretTime(urlStr: String, vc: ProblemDetailVC) {
        guard let url = URL(string: urlStr) else { return }
        var res = ""
        let request = AF.request(url)
        request.authenticate(username: "test@test.com", password: "testtesttest").validate(statusCode: [200, 201, 202]).response { [self] (response) in
            switch response.result {
            case .success(let value):
                guard let data = value else { return }
                let json = JSON(data)
                let wallCretTime = json["lastWallCreationTime"].stringValue
                res = urlStr + "/walls/" + wallCretTime + "/routes"
                print(res)
                
                vc.loadLastProblemCretTime(urlStr: res, vc: vc)
            default:
                return
            }
        }
    }
    
    func loadLastProblemCretTime(urlStr: String, vc: ProblemDetailVC) {
        guard let url = URL(string: urlStr) else { return }
        print(urlStr)
        var res = ""
        AF.request(url).authenticate(username: "test@test.com", password: "testtesttest").validate(statusCode: [200, 201, 202]).response { [self] (response) in
            switch response.result {
            case .success(let value):
                guard let data = value else { return }
                let json = JSON(data)
                let firstData = json[0]
                let problemCretTime = firstData["creationTime"].stringValue
                res = urlStr + "/1/" + problemCretTime + "/records"
                
                vc.patchProblem(urlStr: res, vc: vc)
            default:
                return
            }
        }
    }
    
    func patchProblem(urlStr: String, vc: ProblemDetailVC) {
        print(urlStr)
        let headers: HTTPHeaders = [
          "Doldamgil-Record-Climber-Id": "1",
          "Accept": "*/*"
        ]
        
        guard let uri = URL(string: urlStr) else {
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
        vc.showAlert()
    }
}

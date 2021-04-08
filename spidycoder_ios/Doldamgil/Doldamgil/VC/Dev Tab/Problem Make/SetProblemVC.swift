//
//  SetProblemVC.swift
//  Doldamgil
//
//  Created by Kyle Yang on 2020/09/08.
//  Copyright © 2020 Kyle Yang. All rights reserved.
//
import UIKit
import Alamofire
import SwiftyJSON

class SetProblemVC: UIViewController {
    var holdList: HoldList?
    var startHold: Int = 0
    var problemRoute: [Int] = [Int]()
    var lastWallCret = ""
    let calibrationHoldImgView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        let lastWallCret = lastWallCreateTime(urlStr: getProblemUrl)
        //        let lastWallCret = loadLastWall(urlStr: getProblemUrl)
        //        print("lastwallcret: ", lastWallCret)
        //        let newRes = lastWallCret.replacingOccurrences(of: ":", with: "%3A", options: .literal, range: nil)
        //        print("newRes: ", newRes)
//        let holdListUrl    = "https://s3.ap-northeast-2.amazonaws.com/s3.doldamgil.spidycoder.com/gyms/1/edges/1/walls/2020-11-17T02%3A27%3A51Z/info"
        
        
        setNaviBar(title: "문제 출제")
        
        startHoldSelectAlert()
        
        view.addSubview(calibrationHoldImgView)
        imgViewSetup()
        addNextBtn()
        
        //        var time = ""
        //        DispatchQueue.global().sync { time = loadLastWallInfo(urlStr: getProblemUrl) }
//        let time = loadLastWallInfo(urlStr: holdListUrl)
        //        print("previous loadHolds", time)
//        print("time: ", time)
        loadLastWallInfo(urlStr: getProblemUrl, testVC: self)
        //        print("hold Done")
    }
}

extension SetProblemVC {
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
    
    func imgViewSetup() {
        //        var bgImg = ""
        //        DispatchQueue.global().sync { bgImg = loadLastWallBg(urlStr: getProblemUrl) }
//        let bgImg = loadLastWallBg(urlStr: getProblemUrl)
        //        print("previous load Bg", bgImg)
//        print("bgImg: ", bgImg)
//        let wallImageUrl   = "https://s3.ap-northeast-2.amazonaws.com/s3.doldamgil.spidycoder.com/gyms/1/edges/1/walls/2020-11-17T02%3A27%3A51Z/background.jpg"
//        calibrationHoldImgView.downloaded(from: wallImageUrl)
        //        print("bg Done")
        loadLastWallBg(urlStr: getProblemUrl, testVC: self)
        
        calibrationHoldImgView.isUserInteractionEnabled = true
        
        calibrationHoldImgView.translatesAutoresizingMaskIntoConstraints = false
        
        calibrationHoldImgView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        calibrationHoldImgView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        calibrationHoldImgView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        calibrationHoldImgView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
    }
    
    func addNextBtn() {
        let nextBtn = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(saveBtnTouchUpInside))
        
        if self.traitCollection.userInterfaceStyle == .dark {
            nextBtn.tintColor = .white
        }
        else {
            nextBtn.tintColor = .twilightBlue
        }
        
        self.navigationItem.rightBarButtonItem = nextBtn
    }
    
    func addHoldBtn(item: Hold, index: Int) -> UIButton {
        let x1 = Double(calibrationHoldImgView.frame.width) * item.leftTopX
        let y1 = Double(calibrationHoldImgView.frame.height) * item.leftTopY
        let x2 = Double(calibrationHoldImgView.frame.width) * item.rightBottomX
        let y2 = Double(calibrationHoldImgView.frame.height) * item.rightBottomY
        
        let holdFrameBtn = UIButton(type: .custom)
        holdFrameBtn.layer.borderColor = UIColor.clear.cgColor
        holdFrameBtn.layer.borderWidth = 1
        holdFrameBtn.setBackgroundColor(color: .lightGray, forState: .normal)
        holdFrameBtn.alpha = 0.75
        holdFrameBtn.adjustsImageWhenHighlighted = false
        
        holdFrameBtn.frame = CGRect(x: x1, y: y1, width: (x2 - x1), height: (y2 - y1))
        holdFrameBtn.tag = index
        holdFrameBtn.setTitleColor(.black, for: .normal)
        holdFrameBtn.setTitle(String(holdFrameBtn.tag), for: .normal)
        holdFrameBtn.titleLabel?.font = UIFont.systemFont(ofSize: 9)
        
        return holdFrameBtn
    }
    
    func startHoldSelectAlert() {
        let startAlert = UIAlertController(title: "스타트 홀드 개수", message: "시작 홀드의 갯수를 선택해주세요", preferredStyle: .actionSheet)
        startAlert.addAction(UIAlertAction(title: "1개", style: .default) { (_) in
            self.startHold = 1
        })
        startAlert.addAction(UIAlertAction(title: "2개", style: .default) { (_) in
            self.startHold = 2
        })
        startAlert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        
        self.present(startAlert, animated: true)
    }
    
//    func bringLastTime(time: String) {
//        self.lastWallCret = time
//    }
}

// MARK: - @objc func
extension SetProblemVC {
    @objc func holdSelect(sender: UIButton) {
        if startHold == 1 {
            if problemRoute.count <= 0 {
                sender.setBackgroundColor(color: .green, forState: .selected)
            }
            else {
                sender.setBackgroundColor(color: .twilightBlue, forState: .selected)
            }
        } else if startHold == 2 {
            if problemRoute.count <= 1 {
                sender.setBackgroundColor(color: .green, forState: .selected)
            }
            else {
                sender.setBackgroundColor(color: .twilightBlue, forState: .selected)
            }
        }
        
        sender.isSelected.toggle()
        if problemRoute.contains(sender.tag) {
            let index = problemRoute.firstIndex(of: sender.tag)!
            problemRoute.remove(at: index)
            print(problemRoute)
        } else {
            problemRoute.append(sender.tag)
            print(problemRoute)
        }
    }
    
    @objc func saveBtnTouchUpInside() {
        let vc = SetProblemDetailVC()
        self.navigationController?.pushViewController(vc, animated: true)
        
        var start = [Int]()
        var finish = [Int]()
        var step = [Int]()
        
        if startHold == 1 {
            start.append(problemRoute[0])
            let lastIndex = problemRoute.count - 1
            finish.append(problemRoute[lastIndex])
            step = Array(problemRoute[1..<lastIndex])
        } else {
            start.append(problemRoute[0])
            start.append(problemRoute[1])
            let lastIndex = problemRoute.count - 1
            finish.append(problemRoute[lastIndex])
            step = Array(problemRoute[2..<lastIndex])
        }
        
        vc.start = start
        vc.steps = step
        vc.finish = finish
        print(start, step, finish)
        
        let problemImg = calibrationHoldImgView.capture()
        vc.problemImgView = problemImg as! UIImageView
    }
}

// MARK: - Network func
extension SetProblemVC {
    // MARK: - loadHold
    func loadHolds(urlStr: String) {
        guard let url = URL(string: urlStr) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else {
                fatalError("Invalid Data")
            }
            
            do {
                self.holdList = try JSONDecoder().decode(HoldList.self, from: data)
                
                DispatchQueue.main.async {
                    if let items = self.holdList?.holds {
                        for item in items {
                            let holdBorderBtn = self.addHoldBtn(item: item, index: item.id)
                            holdBorderBtn.addTarget(self, action: #selector(self.holdSelect(sender:)), for: .touchUpInside)
                            self.calibrationHoldImgView.addSubview(holdBorderBtn)
                        }
                    }
                }
            } catch {
                print("Data Parsing Error")
            }
        }
        task.resume()
    }
    
    func loadLastWallInfo(urlStr: String, testVC: SetProblemVC) {
        guard let url = URL(string: urlStr) else { return }
        
        var res = ""
        var newRes = ""
        var fullRes = ""
        let request = AF.request(url)
        
        request.authenticate(username: "test@test.com", password: "testtesttest").validate(statusCode: [200, 201, 202]).response { [self] (response) in
            switch response.result {
            case .success(let value):
                guard let data = value else { return }
                let json = JSON(data)
                let wallCretTime = json["lastWallCreationTime"].stringValue
                print("wallcret: ", wallCretTime)
                res = wallCretTime
                newRes = res.replacingOccurrences(of: ":", with: "%3A", options: .literal, range: nil)
                print("newRes:", newRes)
                
                fullRes = s3Url + newRes + "/info"
                print(fullRes)
                testVC.loadHolds(urlStr: fullRes)
            default:
                return
            }
        }
        //        print(fullRes)
//        return fullRes
    }
    
    func loadLastWallBg(urlStr: String, testVC: SetProblemVC) {
        guard let url = URL(string: urlStr) else { return }
        
        var res = ""
        var newRes = ""
        var fullRes = ""
        let request = AF.request(url)
        
        request.authenticate(username: "test@test.com", password: "testtesttest").validate(statusCode: [200, 201, 202]).response { (response) in
            switch response.result {
            case .success(let value):
                guard let data = value else { return }
                let json = JSON(data)
                let wallCretTime = json["lastWallCreationTime"].stringValue
                //print("wallcret: ", wallCretTime)
                res = wallCretTime
                newRes = res.replacingOccurrences(of: ":", with: "%3A", options: .literal, range: nil)
                //                print("newRes:", newRes)
                
                fullRes = s3Url + newRes + "/background.jpg"
                print(fullRes)
                testVC.calibrationHoldImgView.downloaded(from: fullRes)
            default:
                return
            }
        }
//        print(fullRes)
//        return fullRes
    }
}

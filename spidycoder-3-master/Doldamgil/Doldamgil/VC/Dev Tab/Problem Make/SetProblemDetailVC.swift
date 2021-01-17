//
//  SetProblemDetailVC.swift
//  Doldamgil
//
//  Created by Kyle Yang on 2020/09/21.
//  Copyright © 2020 Kyle Yang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AWSS3
import AWSCore

class SetProblemDetailVC: UIViewController{
    
    var problemList = [ProblemInfo]()
    
    var start = [Int]()
    var steps = [Int]()
    var finish = [Int]()
    var problemTitle = "테스트 문제"
    var diffi = "Vb (5.3)"
    var climbingProblem = Problem(title: "", difficulty: "", start: [], steps: [], finish: [])
    
    var problemImgView = UIImageView()
    let problemInfoList = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        let vc = SelectDifficultyVC(nibName: "SelectDifficultyVC", bundle: nil)
        //        vc.popVC = self
        //        vc.delegate = self
        
        loadProblems(urlStr: getProblemUrl)
        
        self.navigationItem.title = "문제 출제"
        addDoneBtn()
        
        view.addSubview(problemImgView)
        setImageView()
        
        problemInfoList.delegate = self
        problemInfoList.dataSource = self
        problemInfoList.register(TFInTableViewCell.self, forCellReuseIdentifier: "titleCell")
        problemInfoList.register(UITableViewCell.self, forCellReuseIdentifier: "difficultyCell")
        
        view.addSubview(problemInfoList)
        setTableView()
        problemInfoList.tableFooterView = UIView()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}

extension SetProblemDetailVC {
    //    func getDocumentsDirectory() -> URL {
    //        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    //        return paths[0]
    //    }
    
    func changeDiff(dif difficulty: String) {
        //        problemInfoList.beginUpdates()
        self.diffi = difficulty
        print("dif change", self.diffi)
        //        problemInfoList.endUpdates()
        DispatchQueue.main.async{
            self.problemInfoList.reloadData()
        }
    }
    
    @objc func done() {
        climbingProblem.start = self.start
        climbingProblem.steps = self.steps
        climbingProblem.finish = self.finish
        climbingProblem.title = self.problemTitle
        climbingProblem.difficulty = self.diffi
        print(climbingProblem)
        
        loadLastWall(urlStr: postProblemUrl, test: self)
//        saveProblem(urlStr: postProblemUrl, vc: self)
//        saveProblemImage()
//        saveToS3()
        
//        let vc
    }
    
    // MARK: - ImgView Set
    private func setImageView() {
        self.problemImgView.translatesAutoresizingMaskIntoConstraints = false
        
        self.problemImgView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.problemImgView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.problemImgView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        self.problemImgView.heightAnchor.constraint(equalToConstant: 450).isActive = true
    }
    
    // MARK: - TableView Set
    private func setTableView() {
        self.problemInfoList.translatesAutoresizingMaskIntoConstraints = false
        
        self.problemInfoList.topAnchor.constraint(equalTo: self.problemImgView.bottomAnchor).isActive = true
        self.problemInfoList.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.problemInfoList.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        self.problemInfoList.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func addDoneBtn() {
        let doneBtn = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(done))
        
        if self.traitCollection.userInterfaceStyle == .dark {
            doneBtn.tintColor = .white
        }
        else {
            doneBtn.tintColor = .twilightBlue
        }
        
        self.navigationItem.rightBarButtonItem = doneBtn
    }
    
    func saveProblemImage() {
        // get the documents directory url
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        // choose a name for your image
        let fileName = "problemImage.jpg"
        // create the destination file url to save your image
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        // get your UIImage jpeg data representation and check if the destination file url already exists
        if let data = problemImgView.image?.jpegData(compressionQuality:  1.0),
           !FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                // writes the image data to disk
                try data.write(to: fileURL)
                print("file saved")
            } catch {
                print("error saving file:", error)
            }
        }
    }
    
    func showDoneAlert() {
        let doneAlert = UIAlertController(title: "문제 생성 완료!", message: "", preferredStyle: .alert)
        doneAlert.addAction(UIAlertAction(title: "확인", style: .default, handler: { (action) in
            let vc = ProblemListVC(list: self.problemList)
            self.navigationController?.pushViewController(vc, animated: true)
        }))
        
        present(doneAlert, animated: true, completion: nil)
    }
}

//MARK: - Network
extension SetProblemDetailVC {
    func loadProblems(urlStr: String) {
        guard let url = URL(string: urlStr) else {
            return
        }
        
        let request = AF.request(url)
        request.authenticate(username: "test@test.com", password: "testtesttest").validate(statusCode: [200, 201, 202]).response { [self] (response) in
            switch response.result {
            case .success(let value):
                guard let data = value else { return }
                let json = JSON(data)
                for (_, j) in json {
                    let addItem = getProblemInfo(infoList: j)
                    self.problemList.append(addItem)
                }
            //                print(self.problemList)
            
            default:
                return
            }
        }
    }
    
    func getProblemInfo(infoList: JSON) -> ProblemInfo {
        var tmp = ProblemInfo(edgeCode: 0, creatorId: 0, wallCreationTime: Date(), difficulty: "", routeDoc: "", gymId: 0, title: "", creationTime: Date())
        tmp.title = infoList["title"].stringValue
        tmp.difficulty = infoList["difficulty"].stringValue
        tmp.creatorId = infoList["creatorId"].intValue
        tmp.edgeCode = infoList["edgeCode"].intValue
        tmp.gymId = infoList["gymId"].intValue
        
        return tmp
    }
    
    func saveProblem(urlStr: String, vc: SetProblemDetailVC) {
        print("save url: ", urlStr)
        guard let url = URL(string: urlStr) else { return }
        
        let request = AF.request(url, method: .post, parameters: climbingProblem, encoder: JSONParameterEncoder.default)
        request.authenticate(username: "test@test.com", password: "testtesttest").validate(statusCode: [200, 201, 202]).response { (response) in
            switch response.result {
            case .success(let _):
                print("suc")
            //  print(JSON(value))
                vc.showDoneAlert()
            default:
                return
            }
        }
    }
    
    func loadLastWall(urlStr: String, test: SetProblemDetailVC) {
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
                newRes = wallCretTime.replacingOccurrences(of: ":", with: "%3A", options: .literal, range: nil)
                res = urlStr + "/walls/" + newRes + "/routes"
            
                test.saveProblem(urlStr: res, vc: test)
            default:
                return
            }
        }
//        return res
    }
    
//    func saveToS3() {
//        let accessKey = "AKIAQS6Z7Q2KPQNBAJXZ"
//        let secretKey = "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"
//        let credentialsProvider = AWSStaticCredentialsProvider(accessKey: accessKey, secretKey: secretKey)
//        let configuration = AWSServiceConfiguration(region: AWSRegionType.APNortheast2, credentialsProvider: credentialsProvider)
//        AWSServiceManager.default().defaultServiceConfiguration = configuration
//
//        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//        let fileURL = documentsDirectory.appendingPathComponent("problemImage.jpg")
//        do {
//            let imageData = try Data(contentsOf: fileURL)
//            print("Success")
//        } catch {
//            print("Error loading image : \(error)")
//        }
//
//        let url = fileURL
//        let remoteName = "Name of uploaded file"
//        let S3BucketName = "s3.doldamgil.spidycoder.com/gyms/1/edges/1/walls/2020-11-09T03:30:45Z/routes/1"
//        let uploadRequest = AWSS3TransferManagerUploadRequest()!
//        uploadRequest.body = url
//        uploadRequest.key = remoteName
//        uploadRequest.bucket = S3BucketName
//        uploadRequest.contentType = "image/jpeg"
//        uploadRequest.acl = .publicRead
//
//        let transferManager = AWSS3TransferManager.default()
//
//        transferManager.upload(uploadRequest).continueWith(block: { (task: AWSTask<AnyObject>) -> Any? in
//            if let error = task.error {
//                print("Upload failed with error: (\(error.localizedDescription))")
//            }
//            if task.result != nil {
//                let url = AWSS3.default().configuration.endpoint.url
//                let publicURL = url?.appendingPathComponent(uploadRequest.bucket!).appendingPathComponent(uploadRequest.key!)
//                print("Uploaded to:\(publicURL)")
//            }
//            return nil
//        })
//    }
}


// MARK: - tableview delegate, datasource
extension SetProblemDetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "titleCell") as! TFInTableViewCell
            cell.selectionStyle = .none
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "difficultyCell")
            // 난이도 선택 VC에서 값 받아오지만 테이블 뷰 데이터 변경 X -> 현재 저장이 안됨.
            if self.diffi != "" {
                cell?.textLabel?.text = "\(self.diffi)"
            } else {
                cell?.textLabel?.text = "Vb (5.7)"
            }
            
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1{
            let vc = SelectDifficultyVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

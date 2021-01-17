//
//  ConnectVC.swift
//  Doldamgil
//
//  Created by Kyle Yang on 2020/09/08.
//  Copyright © 2020 Kyle Yang. All rights reserved.
//

import UIKit
import AVFoundation
import Alamofire
import SwiftyJSON

class ConnectVC: UIViewController {
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    var problemList = [ProblemInfo]()
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    let edgeCodeTxtField = UITextField()
    let nextButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        
        setNaviBar(title: "기기 연결")
//        var resUrl = ""
//        DispatchQueue.global().sync { resUrl = loadLastWall(urlStr: getProblemUrl) }
//        let vc = SetProblemVC()
//        vc.bringLastTime(time: resUrl)
//        let getProblemUrl  = "https://test.rest.doldamgil.spidycoder.com:4430/gyms/1/edges/1/walls/2020-11-18T04%3A08%3A28Z/routes"
        loadProblems(urlStr: getProblemUrl)
//        loadLastWall(urlStr: getProblemUrl)
        
        
        
        // MARK: - CaptureSession
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            return
        }
        
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        }
        
        else {
            failed()
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if captureSession.canAddOutput(metadataOutput) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        }
        else {
            failed()
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.frame
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        captureSession.startRunning()
        
        // MARK: - Skip Button
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Skip", style: .plain, target: self, action: #selector(presentAlert))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if captureSession?.isRunning == false {
            captureSession.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if true == captureSession?.isRunning {
            captureSession.stopRunning()
        }
    }
}

extension ConnectVC {
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
    
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not supported", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(ac, animated: true)
        self.captureSession = nil
    }
    
    @objc func presentAlert() {
        let alert = UIAlertController(title: "유형", message: "원하는 메뉴를 골라주세요", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "문제 풀기", style: .default, handler: { (_) in
            self.pushListVC()
        }))
        alert.addAction(UIAlertAction(title: "문제 출제", style: .default, handler: { (_) in
            self.pushSetVC()
        }))
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: { (cancel) in
            self.captureSession.startRunning()
        }))
        
        self.present(alert, animated: true)
    }

    // MARK: - 넘어가는 부분
    @objc func pushListVC() {
        
        let vc = ProblemListVC(list: self.problemList)
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func pushSetVC() {
        let vc = SetProblemVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Network
extension ConnectVC {
    func loadProblems(urlStr: String) {
        guard let url = URL(string: urlStr) else { return }
        
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
            default:
                return
            }
        }
    }
    
    func loadLastWall(urlStr: String) {
        guard let url = URL(string: urlStr) else { return }
        var res = ""
        let request = AF.request(url)
        request.authenticate(username: "test@test.com", password: "testtesttest").validate(statusCode: [200, 201, 202]).response { [self] (response) in
            switch response.result {
            case .success(let value):
                guard let data = value else { return }
                let json = JSON(data)
                let wallCretTime = json["lastWallCreationTime"].stringValue
                res = urlStr + wallCretTime + "/"
                print(res)
                
//                test.loadProblems(urlStr: res)
            default:
                return
            }
        }
//        return res
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
}

extension ConnectVC: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count == 0 {
            return
        }
        
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        if metadataObj.type == AVMetadataObject.ObjectType.qr {
            if let outputString = metadataObj.stringValue {
                DispatchQueue.main.async {
                    let urlStr = mainUrl + outputString
                    print(urlStr)
                    if let edgeCode = outputString.components(separatedBy: "/").last {
                        self.edgeCodeTxtField.text = edgeCode
                    }
                    
                    guard let url = URL(string: urlStr) else {
                        return
                    }
                    
                    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                        if let error = error {
                            print(error)
                            return
                        }
                        
                        guard let httpResponse = response as? HTTPURLResponse else {
                            return
                        }
                        
                        guard (200...299).contains(httpResponse.statusCode) else {
                            return
                        }
                        
//                        guard let data = data else {
//                            fatalError("Invalid Data")
//                        }
                    }
                    
                    task.resume()
                }
                captureSession.stopRunning()
            }
            
            presentAlert()
        }
    }
}

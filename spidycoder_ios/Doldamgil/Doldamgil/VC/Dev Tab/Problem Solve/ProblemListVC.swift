//
//  ProblemListVC.swift
//  Doldamgil
//
//  Created by Kyle Yang on 2020/09/08.
//  Copyright © 2020 Kyle Yang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ProblemListVC: UIViewController {
    
    var diffSegCon = UISegmentedControl()
    let problemListTableView = UITableView()
    
    var infoList = [ProblemInfo]()
    
    init(list problemList: [ProblemInfo]) {
        self.infoList = problemList
        super.init(nibName: nil, bundle: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNaviBar(title: "문제 목록")
        
        problemListTableView.delegate = self
        problemListTableView.dataSource = self
        problemListTableView.register(ProblemInfoInTableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(problemListTableView)
        setProblemListTableView()
        problemListTableView.tableFooterView = UIView()
        
        let rightBarBtn = UIBarButtonItem(image: UIImage(named: "penSquare"), style: .plain, target: self, action: #selector(add))
        self.navigationItem.rightBarButtonItem = rightBarBtn
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.problemListTableView.reloadData()
    }
    
    @objc func add() {
        let vc = SetProblemVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ProblemListVC {
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
    
    func setProblemListTableView() {
        problemListTableView.translatesAutoresizingMaskIntoConstraints = false
        problemListTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        problemListTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        problemListTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        problemListTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
    }
}

// MARK: - Network Func
extension ProblemListVC {

}

extension ProblemListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProblemInfoInTableViewCell
        cell.titleLbl.text = infoList[indexPath.row].title
        cell.difficultyLbl.text = infoList[indexPath.row].difficulty
        cell.creatorLbl.text = String(infoList[indexPath.row].creatorId)
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ProblemDetailVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//
//  SelectDifficulty.swift
//  Doldamgil
//
//  Created by Kyle Yang on 2020/10/21.
//  Copyright © 2020 Kyle Yang. All rights reserved.
//

import UIKit


class SelectDifficultyVC: UIViewController {
    
    let diffiTableView = UITableView()
    let newbies = ["Vb (5.7)", "V0- (5.9)"]
    let intermediates = ["V0 (5.10a)", "V0+ (5.10c)", "V1 (5.10d)", "V2 (5.11a)"]
    let highs = ["V3 (5.11d)", "V4 (5.12a)", "V5 (5.12c)", "V6 (5.12d)"]
    let experts = ["V7 (5.13a)", "V8 (5.13c)", "V9 (5.13d)", "V10 (5.14a)", "V11 (5.14c)", "V12 (5.14d)", "V13 (5.14d)", "V14 (5.15a)", "V15 (5.15b)", "V16 (5.15c)"]
    let sections = ["초급", "중급", "고급", "전문가"]
    
//    var popVC: SetProblemDetailVC?
//    weak var delegate: DifficultyDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        diffiTableView.delegate = self
        diffiTableView.dataSource = self
        diffiTableView.register(UITableViewCell.self, forCellReuseIdentifier: "diffiCell")
        view.addSubview(diffiTableView)
        setTableView()
        diffiTableView.tableFooterView = UIView()
    }
}

extension SelectDifficultyVC {
    private func setTableView() {
        self.diffiTableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.diffiTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.diffiTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.diffiTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        self.diffiTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

extension SelectDifficultyVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let popVC = SetProblemDetailVC()
//        popVC.changeDiff(dif: difficulties[indexPath.row])
        if indexPath.section == 0 {
            popVC.changeDiff(dif: "\(newbies[indexPath.row])")
        } else if indexPath.section == 1 {
            popVC.changeDiff(dif: "\(intermediates[indexPath.row])")
        } else if indexPath.section == 2 {
            popVC.changeDiff(dif: "\(highs[indexPath.row])")
        } else if indexPath.section == 3 {
            popVC.changeDiff(dif: "\(experts[indexPath.row])")
        } else {
            return
        }
//        delegate?.changeDifficulty(dif: difficulties[indexPath.row])
        
        
        self.navigationController?.popViewController(animated: true)
    }
}

extension SelectDifficultyVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    // Returns the title of the section.
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return newbies.count
        } else if section == 1 {
            return intermediates.count
        } else if section == 2 {
            return highs.count
        } else if section == 3 {
            return experts.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "diffiCell")
        if indexPath.section == 0 {
            cell?.textLabel?.text = "\(newbies[indexPath.row])"
        } else if indexPath.section == 1 {
            cell?.textLabel?.text = "\(intermediates[indexPath.row])"
        } else if indexPath.section == 2 {
            cell?.textLabel?.text = "\(highs[indexPath.row])"
        } else if indexPath.section == 3 {
            cell?.textLabel?.text = "\(experts[indexPath.row])"
        } else {
            return UITableViewCell()
        }
        
        return cell!
    }
}

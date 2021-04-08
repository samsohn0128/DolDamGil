//
//  HomeVC.swift
//  Doldamgil
//
//  Created by Kyle Yang on 2020/09/08.
//  Copyright © 2020 Kyle Yang. All rights reserved.
//

import UIKit
import FSCalendar

class HomeVC: UIViewController {
    
    let calendar = FSCalendar()
    let dayListTableView = UITableView()
    let dayList = ["날으는 돼지 성공", "Show me the money 성공", "이건 어려워 실패"]
    
    //
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        // MARK: - Calendar Set
        calendar.delegate = self
        calendar.dataSource = self
        
        view.addSubview(calendar)
        calendar.register(FSCalendarCell.self, forCellReuseIdentifier: "calCell")
        calSetup()
        calAppearConfiguration()
        
        // MARK: - TableView Set
        dayListTableView.delegate = self
        dayListTableView.dataSource = self
        
        dayListTableView.register(UITableViewCell.self, forCellReuseIdentifier: "listCell")
        view.addSubview(dayListTableView)
        dayListTableView.tableFooterView = UIView()
        tableViewSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // MARK: - NavigationBar Configuration
//        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = .twilightBlue
        self.navigationController?.navigationBar.tintColor = .white
        setLeftAlignedNavigationItemTitle(text: "안녕하세요! gaeng님", color: .white, margin: 30)
    }
}

//MARK: - function define
extension HomeVC {
    
    // MARK: - NavigationBar Title Left Alignment
    private func setLeftAlignedNavigationItemTitle(text: String, color: UIColor, margin left: CGFloat) {
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 24, weight: .regular)
        titleLabel.textColor = color
        titleLabel.text = text
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.navigationItem.titleView = titleLabel
        
        guard let containerView = self.navigationItem.titleView?.superview else {
            return
        }
        
        // NOTE: This always seems to be 0. Huh??
        let leftBarItemWidth = self.navigationItem.leftBarButtonItems?.reduce(0, {
            $0 + $1.width
        })
        
        let notiIcon = UIBarButtonItem(image: UIImage(named: "notification"), style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = notiIcon
        navigationItem.rightBarButtonItem?.tintColor = .white
        
        
        titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: (leftBarItemWidth ?? 0) + left).isActive = true
        //        titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        titleLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 200).isActive = true
    }
    
}

// MARK: - FSCalendar Extension
extension HomeVC: FSCalendarDelegate, FSCalendarDataSource {
    // MARK: - Calendar Autolayout
    private func calSetup() {
        calendar.translatesAutoresizingMaskIntoConstraints = false
        
        calendar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        calendar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        calendar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        calendar.heightAnchor.constraint(equalToConstant: 400).isActive = true
    }
    
    // MARK: - Calendar Appearance
    private func calAppearConfiguration() {
        // 전달 다음달 날짜 없애기
        calendar.placeholderType = .none
        
        calendar.backgroundColor = .twilightBlue
        
        calendar.appearance.todayColor = UIColor(displayP3Red: 255/255, green: 255/255, blue: 244/255, alpha: 0.15)
        
        calendar.appearance.eventDefaultColor = .systemRed
        
        calendar.appearance.headerDateFormat = "MMM yyyy"
        calendar.appearance.headerMinimumDissolvedAlpha = 0
        calendar.appearance.headerTitleFont = .systemFont(ofSize: 20, weight: .bold)
        calendar.appearance.headerTitleColor = .white
        
        calendar.headerHeight = 70
        
        //
        calendar.appearance.weekdayFont = UIFont.systemFont(ofSize: 17, weight: .semibold)
        calendar.appearance.weekdayTextColor = .white
        calendar.calendarWeekdayView.weekdayLabels[0].textColor = .systemRed
        calendar.calendarWeekdayView.backgroundColor = UIColor(displayP3Red: 255/255, green: 255/255, blue: 244/255, alpha: 0.15)
        
        calendar.appearance.titleFont = .systemFont(ofSize: 13, weight: .semibold)
        calendar.appearance.titleDefaultColor = .white
        
        //        calendar.appearance.sel
        
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(date)
    }
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "calCell", for: date, at: position)
        
        return cell
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    private func tableViewSetup() {
        dayListTableView.translatesAutoresizingMaskIntoConstraints = false
        
        dayListTableView.topAnchor.constraint(equalTo: calendar.bottomAnchor).isActive = true
        dayListTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        dayListTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        dayListTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
//        cell?.textLabel?.text = dayList[indexPath.row].problemTitle
        cell.textLabel?.text = dayList[indexPath.row]

        return cell
    }
    
    
}

//
//  SearchVC.swift
//  Doldamgil
//
//  Created by Kyle Yang on 2020/09/08.
//  Copyright © 2020 Kyle Yang. All rights reserved.
//

import UIKit
import CoreLocation

class SearchVC: UIViewController {
    
    //    var locationManager = CLLocationManager()
    
    let searchCon = UISearchController(searchResultsController: nil)
    let tableView = UITableView()
    
    let testCenterList = ["강남 클라이밍 파크", "비블럭 클라이밍", "V10 클라이밍 센터", "맑음 클라이밍", "은평 실내 암벽장", "스포츠 몬스터", "카인드짐", "에이스 클라이밍 센터", "SUMMIT 클라이밍센터", "빅 클라이밍짐"]
    var filteredCenters = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        
        // 위치 가져오기
        //        locationManager.delegate = self
        //        locationManager.requestAlwaysAuthorization()
        //        //or use requestWhenInUseAuthorization()
        //        locationManager.requestWhenInUseAuthorization()
        //        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //        locationManager.startUpdatingLocation()
        //        locationManager.allowsBackgroundLocationUpdates = true
        //        locationManager.pausesLocationUpdatesAutomatically = false
        
        // MARK: - TableView Set
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "centerListCell")
        
        view.addSubview(tableView)
        tableViewSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = "클라이밍 센터 검색"
        searchControllerSetup()
        
    }
}

// MARK: - Function Defnie
extension SearchVC {
    private func tableViewSetup() {
        tableView.tableFooterView = UIView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    private func searchControllerSetup() {
        // 프로토콜 채택 -> 서치바에서 텍스트 변경되는 것을 알림
        searchCon.searchResultsUpdater = self
        // 표시된 뷰를 흐리게(obscure) 만들지만 그 기능을 끄는 것 현재 뷰컨에 결과를 표시하기 때문에
        searchCon.obscuresBackgroundDuringPresentation = false
        searchCon.searchBar.placeholder = "키워드 입력"
        navigationItem.searchController = searchCon
        // searchCon 이 활성화되어있는 동안 사용자가 다른 VC로 이동하면 searchBar가 화면에 남아 있지 않도록
        definesPresentationContext = true
    }
    
    private func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchCon.searchBar.text?.isEmpty ?? true
    }
    
    private func filterContentForSearchTest(for searchText: String) {
        filteredCenters = testCenterList.filter { center in
          return
            center.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
    
    private func isFiltering() -> Bool {
        return searchCon.isActive && !searchBarIsEmpty()
    }
}

extension SearchVC: CLLocationManagerDelegate {
    
}

extension SearchVC: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchTest(for: searchCon.searchBar.text ?? "")
    }
}

extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredCenters.count
        }
        
        return testCenterList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "centerListCell", for: indexPath)
        
        var list: String
        if isFiltering() {
            list = filteredCenters[indexPath.row]
        }
        else {
            list = testCenterList[indexPath.row]
        }
        
        cell.textLabel?.text = testCenterList[indexPath.row]
        
        return cell
    }
}

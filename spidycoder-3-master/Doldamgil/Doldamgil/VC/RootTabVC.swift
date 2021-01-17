//
//  TabVC.swift
//  Doldamgil
//
//  Created by Kyle Yang on 2020/10/16.
//  Copyright © 2020 Kyle Yang. All rights reserved.
//

import UIKit

class RootTabVC: UITabBarController {
    
    let homeNC = UINavigationController(rootViewController: HomeVC())
    let connectNC = UINavigationController(rootViewController: ConnectVC())
    let searchNC = UINavigationController(rootViewController: SearchVC())
    let myPageNC = UINavigationController(rootViewController: MyPageVC())
    
    // create tabbar with array of nav controllers
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.barTintColor = .systemBackground
        tabBar.tintColor = .twilightBlue
        tabBar.unselectedItemTintColor = .lightGray
        
        setTabBar()
    }

    func setTabBar() {
        let firstVC = UINavigationController(rootViewController: HomeVC())
        firstVC.tabBarItem.image = UIImage(named: "tab1")
        firstVC.tabBarItem.title = "메인 페이지"
        
        let secondVC = UINavigationController(rootViewController: ConnectVC())
        secondVC.tabBarItem.image = UIImage(named: "tab2")
        secondVC.tabBarItem.title = "기기 연결"
         
        let thirdVC = UINavigationController(rootViewController: SearchVC())
        thirdVC.tabBarItem.image = UIImage(named: "tab3")
        thirdVC.tabBarItem.title = "센터 검색"
        
        let fourthVC = UINavigationController(rootViewController: MyPageVC())
        fourthVC.tabBarItem.image = UIImage(named: "tab4")
        fourthVC.tabBarItem.title = "마이 페이지"
        
//        viewControllers = [firstVC, secondVC, thirdVC, fourthVC]
        viewControllers = [secondVC, firstVC, thirdVC, fourthVC]
    }
}

extension RootTabVC {
//    // MARK: - TabBar에 넣을 VC를 생성
//    func createHomeNavigationController() -> UINavigationController {
//        // we create the view controller and insert into the nav controller and return
//        let homeVC = HomeVC()
//        homeVC.title = "메인 페이지"
//        homeVC.tabBarItem.image = UIImage(named: "tab1")
//        return UINavigationController(rootViewController: homeVC)
//    }
//    
//    func createConnectNavigationController() -> UINavigationController {
//        // we create the view controller and insert into the nav controller and return
//        let connectVC = ConnectVC()
//        connectVC.title = "기기 연결"
//        connectVC.tabBarItem.image = UIImage(named: "tab2")
//        return UINavigationController(rootViewController: connectVC)
//        
//    }
//    
//    func createSearchNavigationController() -> UINavigationController {
//        // we create the view controller and insert into the nav controller and return
//        let searchVC = SearchVC()
//        searchVC.title = "센터 검색"
//        searchVC.tabBarItem.image = UIImage(named: "tab3")
//        return UINavigationController(rootViewController: searchVC)
//    }
//    
//    func createMyPageNavigationController() -> UINavigationController {
//        // we create the view controller and insert into the nav controller and return
//        let myPageVC = MyPageVC()
//        myPageVC.title = "마이 페이지"
//        myPageVC.tabBarItem.image = UIImage(named: "tab4")
//        return UINavigationController(rootViewController: myPageVC)
//    }
//    
//    // MARK: - TabBar 만들기
//    func createtabbar() -> UITabBarController {
//        let tabBar = UITabBarController()
//        
//        // dark mode 지원하기
////        UIApplication.shared.windows.forEach { window in
////            if window.traitCollection.userInterfaceStyle == .dark {
////                tabBar.tabBar.unselectedItemTintColor = .white
////            }
////        }
//        
//        tabBar.tabBar.tintColor = UIColor.twilightBlue
//        
//        // tabBar에 VC를 넣기
//        tabBar.viewControllers = [createHomeNavigationController(), createConnectNavigationController(), createSearchNavigationController(), createMyPageNavigationController()]
//        return tabBar
//    }
//    
}

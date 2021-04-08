//
//  SceneDelegate.swift
//  Doldamgil
//
//  Created by Kyle Yang on 2020/09/08.
//  Copyright © 2020 Kyle Yang. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    // MARK: - iOS 13 부터는 여기에 window 생성
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        // 상수에 이름 주기
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }

        // 전체 윈도우
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        // 함수로 묶어서 명시적으로
        // 탭에 넣을 VC들 넣기
        
        // Array 형식 알아보기
    
        let rootVC = FirstVC()
        let naviVC = UINavigationController(rootViewController: rootVC)
        
//        window?.rootViewController = createtabbar()
        window?.rootViewController = naviVC
        window?.makeKeyAndVisible()//
    }
    

//    func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
//        let userInterfaceStyle = traitCollection.userInterfaceStyle // Either .unspecified, .light, or .dark
//        // Update your user interface based on the appearance
//        if userInterfaceStyle == .dark {P}
//    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        
        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    
}


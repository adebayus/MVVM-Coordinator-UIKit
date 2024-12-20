//
//  AppDelegate.swift
//  UIKitCoordinator
//
//  Created by MacBook Air MII  on 11/11/24.
//

import UIKit
import SwiftKeychainWrapper

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
//        KeychainWrapper.standard.removeAllKeys()
        if #available(iOS 13, *) {
            
            
        } else {
            self.window = UIWindow(frame: UIScreen.main.bounds )
            
            let navControler = UINavigationController()
            appCoordinator = AppCoordinator(navigationController: navControler)
            appCoordinator!.start()
            
            window!.rootViewController = navControler
            window!.makeKeyAndVisible()
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

func setupStyleNavigationBar() {
    if #available(iOS 13.0, *) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .backgroundPrimary
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    } else {
        // Fallback on earlier versionssa
        let navigationBar = UINavigationBar.appearance()
        navigationBar.tintColor = UIColor.systemBlue
        navigationBar.tintColor = UIColor.white
    }
}

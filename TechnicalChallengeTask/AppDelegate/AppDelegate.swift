//
//  AppDelegate.swift
//  TechnicalChallengeTask
//
//  Created by Maksym Vitovych on 04.02.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupRootVC()
        // Override point for customization after application launch.
        return true
    }
    
    private func setupRootVC() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = RepositoriesListViewController.builder.default()
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
}


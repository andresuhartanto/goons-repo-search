//
//  AppDelegate.swift
//  Goons RepoSearch
//
//  Created by Andre on 2025/4/15.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Initialize the window
        window = UIWindow(frame: UIScreen.main.bounds)
        
        showRepoList()
        
        return true
    }
}

// Present RepoList Page
extension AppDelegate {
    func showRepoList() {
        guard let window = window else {
            print("[❗️] Window is nil")
            return
        }
        
        let repoListViewController = UINavigationController(rootViewController: RepoListViewController())

        window.rootViewController = repoListViewController
        window.makeKeyAndVisible()
    }
}

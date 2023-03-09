//
//  AppDelegate.swift
//  Blanball
//
//  Created by Misha Deneka on 27.02.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var appCoordinator: AppCoordinator!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        appCoordinator = AppCoordinator()
        appCoordinator.setRoot(for: window)
        
        //window.makeKeyAndVisible()
        return true
    }
}


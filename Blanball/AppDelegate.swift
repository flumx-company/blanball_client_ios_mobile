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
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
//        self.window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewController")
        let viewModel = LoginViewModel(apiClient: LoginAPIClientImpl())
        self.window?.rootViewController = LoginViewController(viewModel: viewModel)
        
        return true
    }
}


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
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        appCoordinator = AppCoordinator()
        appCoordinator.setRoot(for: window)
//        self.window?.rootViewController = LoadingViewController(nibName: "LoadingViewController", bundle: nil)
//        self.window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewController")
        let viewModel = LoginViewModel(apiClient: LoginAPIClientImpl())
        self.window?.rootViewController = LoginViewController(viewModel: viewModel)
        
        //window.makeKeyAndVisible()
        return true
    }
}


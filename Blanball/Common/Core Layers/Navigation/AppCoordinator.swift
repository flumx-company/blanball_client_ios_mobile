//
//  AppCoordinator.swift
//  Blanball
//
//  Created by Misha Deneka on 07.03.2023.
//

import Foundation
import XCoordinator

enum AppRoute: Route {
    case splash
    case login
    case home
}

final class AppCoordinator: NavigationCoordinator<AppRoute> {
    
    // MARK: - Lifecycle -
    
    init() {
        super.init(initialRoute: .login)
        self.rootViewController.setNavigationBarHidden(true, animated: false)
        self.rootViewController.view.backgroundColor = .clear
    }
    
    override func prepareTransition(for route: AppRoute) -> NavigationTransition {
        switch route {
        case .splash:
            return .none()
        case .login:
            let loginCoordinator = LoginCoordinator(rootViewController: self.rootViewController)
            addChild(loginCoordinator)
            return .none()
        case .home:
            return .none()
        }
    }
}

//
//  ResetPasswordCoordinator.swift
//  Blanball
//
//  Created by Nik Dub on 24.03.2023.
//

import UIKit
import XCoordinator

enum ResetPasswordRoute: Route {
    case login
    case signUp
    case resetPassword
}

final class ResetPasswordCoordinator: NavigationCoordinator<LoginRoute> {
    
    // MARK: - Lifecycle -
    
    init(rootViewController: UINavigationController) {
        super.init(rootViewController: rootViewController, initialRoute: .login)
        self.rootViewController.setNavigationBarHidden(true, animated: false)
        self.rootViewController.view.backgroundColor = .clear
    }
    
    override func prepareTransition(for route: LoginRoute) -> NavigationTransition {
        switch route {
        case .login:
            let viewModel = LoginViewModel(
                router: self.unownedRouter,
                apiClient: LoginAPIClientImpl()
            )
            let viewController = LoginViewController(viewModel: viewModel)
            return .set([viewController])
        case .signUp:
            let viewModel = LoginViewModel(
                router: self.unownedRouter,
                apiClient: LoginAPIClientImpl()
            )
            let viewController = LoginViewController(viewModel: viewModel)
            return .set([viewController])
        case .resetPassword:
            return .none()
        }
    }
}

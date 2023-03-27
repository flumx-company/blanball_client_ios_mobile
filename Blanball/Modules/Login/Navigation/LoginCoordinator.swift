//
//  LoginCoordinator.swift
//  Blanball
//
//  Created by Misha Deneka on 09.03.2023.
//

import UIKit
import XCoordinator

enum LoginRoute: Route {
    case login
    case signUp
    case resetPassword
}

final class LoginCoordinator: NavigationCoordinator<LoginRoute> {
    
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
                router: self.strongRouter,
                apiClient: LoginAPIClientImpl()
            )
            let viewController = LoginViewController(viewModel: viewModel)
            return .set([viewController])
        case .signUp:
            return .none()
        case .resetPassword:
            let viewModel = ResetPasswordViewModel(
//                router: self.unownedRouter,
//                apiClient: LoginAPIClientImpl()
                state: .started)
            let viewController = ResetPasswordViewController(viewModel: viewModel)
            return .set([viewController])
        }
    }
}

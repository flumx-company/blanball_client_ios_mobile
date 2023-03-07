//
//  LoginViewModel.swift
//  Blanball
//
//  Created by Nikita Dubovik on 05.03.2023.
//

import Foundation
import XCoordinator

final class LoginViewModel: BaseViewModel<LoginViewModelState> {
    
    private let router: UnownedRouter<LoginRoute>
    private let apiClient: LoginAPIClient
    
    init(
        router: UnownedRouter<LoginRoute>,
        apiClient: LoginAPIClient
    ) {
        self.apiClient = apiClient
        self.router = router
        super.init(state: .started)
    }
    
    override func start() {
        updateState(newValue: .loading)
    }
    
    private func fetchLogin() async {
        Task { 
            do {
                let login = try await self.apiClient.login(reqModel: .init(email: .empty, password: .empty))
                self.updateState(newValue: .updated)
            } catch {
                self.updateState(newValue: .failure(error: error))
            }
        }
    }
}

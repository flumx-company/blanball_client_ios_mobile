//
//  LoginViewModel.swift
//  Blanball
//
//  Created by Nikita Dubovik on 05.03.2023.
//

import Foundation
import XCoordinator

final class LoginViewModel: BaseViewModel<LoginViewModelState> {
    
    private let apiClient: LoginAPIClient
    
    init(apiClient: LoginAPIClient) {
        self.apiClient = apiClient
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

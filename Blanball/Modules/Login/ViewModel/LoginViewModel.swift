//
//  LoginViewModel.swift
//  Blanball
//
//  Created by Nikita Dubovik on 05.03.2023.
//

import Foundation
import XCoordinator
import Combine

final class LoginViewModel: BaseViewModel<LoginViewModelState> {
    
    private let apiClient: LoginAPIClient
    
    private(set) var emailSubject = CurrentValueSubject<BlanRoundedTextFieldState, Never>(.idle)
    private(set) var passwordSubject = CurrentValueSubject<BlanRoundedTextFieldState, Never>(.idle)
    
    init(apiClient: LoginAPIClient) {
        self.apiClient = apiClient
        super.init(state: .started)
    }
    
    override func start() {
        updateState(newValue: .loading)
    }
    
    func bindViewState(publisher: Published<BlanRoundedTextFieldState>.Publisher) {
        publisher.sink { state in
            
        }.store(in: &cancellables)
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

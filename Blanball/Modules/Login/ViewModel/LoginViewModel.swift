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
    
    // MARK: - Private properties -
    
    private let router: UnownedRouter<LoginRoute>!
    private let apiClient: LoginAPIClient
    
    private var login = ""
    private var password = ""
    
    // MARK: - Init -
    
    init(
        router: UnownedRouter<LoginRoute>,
        apiClient: LoginAPIClient
    ) {
        self.apiClient = apiClient
        self.router = router
        super.init(state: .started)
    }
    
    // MARK: - Internal methods -
    
    override func start() {
        updateState(newValue: .loading)
    }
    
    func subscribeToLoginTextFieldPublisher(
        _ publisher: AnyPublisher<BlanRoundedTextFieldState, Never>
    ) {
        publisher
            .sink { state in
                switch state {
                case .updated(let value, _):
                    self.login = value ?? ""
                    break
                default: break
                }
            }.store(in: &cancellables)
    }
    
    func subscribeToPasswordTextFieldPublisher(
        _ publisher: AnyPublisher<BlanRoundedTextFieldState, Never>
    ) {
        publisher
            .sink { state in
                switch state {
                case .updated(let value, _):
                    self.password = value ?? ""
                    break
                default: break
                }
            }.store(in: &cancellables)
    }
    
    func subscribeToForgotPasswordButtonPublisher(
        _ publisher: AnyPublisher<UnderlinedDashButtonState, Never>
    ) {
        publisher
            .sink { [unowned self] state in
                print(state)
                switch state {
                case .tapped:
                    router.trigger(.resetPassword)
                    break
                default: break
                }
            }.store(in: &cancellables)
    }
    
    func fetchLogin(
        login: String,
        password: String
    ) async {
        Task { 
            do {
                _ = try await self.apiClient.login(reqModel: .init(email: login, password: password))
                self.updateState(newValue: .updated)
            } catch {
                self.updateState(newValue: .failure(error: error))
            }
        }
    }
}

//
//  LoginAPIClient.swift
//  Blanball
//
//  Created by Misha Deneka on 05.03.2023.
//

import Foundation

protocol LoginAPIClient {
    func login(reqModel: LoginRequestModel) async throws -> [Int]
}

final class LoginAPIClientImpl: ApiClient<LoginAPI> {}

extension LoginAPIClientImpl: LoginAPIClient {
    func login(reqModel: LoginRequestModel) async throws -> [Int] {
        return try await request(.login(model: reqModel))
    }
}

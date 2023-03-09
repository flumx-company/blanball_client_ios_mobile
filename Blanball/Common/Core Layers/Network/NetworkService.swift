//
//  NetworkService.swift
//  Blanball
//
//  Created by Misha Deneka on 02.03.2023.
//

import Foundation

protocol NetworkManager {
    func request<T: Decodable>(_ model: CommonService) async throws -> T
}

final class NetworkService {
    static let `default` = NetworkService()
}

extension NetworkService: NetworkManager {
    func request<T: Decodable>(_ model: CommonService) async throws -> T {
        
        let urlRequest = try model.asURLRequest()
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.wrongStatusCode(httpResponse.statusCode)
        }
        
        let decoder = JSONDecoder()
        let result = try decoder.decode(T.self, from: data)
        return result
    }
}

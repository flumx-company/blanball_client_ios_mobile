//
//  APIClient.swift
//  Blanball
//
//  Created by Misha Deneka on 03.03.2023.
//

import Foundation
import Combine

open class ApiClient<T: CommonService> {
    
    var networkManager: NetworkManager {
        return NetworkService.default
    }
    

    func request<U: Decodable>(_ service: T) -> Signal<U, NetworkError> {
        Task {
            await networkManager.request(service)
        }
    }
}

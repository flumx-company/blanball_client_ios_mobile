//
//  myApiClient.swift
//  Blanball
//
//  Created by Misha Deneka on 03.03.2023.
//

import Foundation

protocol myApiService {
    func getData() async throws  -> [String]
}

class myApiClient: ApiClient<MyApi> {
    
}

extension myApiClient: myApiService {
    func getData() async throws -> [String] {
        try await request(.test)
    }
}

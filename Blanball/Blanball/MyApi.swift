//
//  MyApi.swift
//  Blanball
//
//  Created by Misha Deneka on 03.03.2023.
//

import Foundation

enum MyApi: CommonService {
    case test
    
    var method: HTTPMethod {
        switch self {
        case .test:
            return .get
        }
    }
    
    var path: String {
        return .empty
    }
    
    var parameters: [String: Any]? {
        return nil
    }
    
    var analyticsName: String {
        return .empty
    }
}

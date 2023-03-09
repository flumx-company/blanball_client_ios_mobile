//
//  LoginAPI.swift
//  Blanball
//
//  Created by Misha Deneka on 05.03.2023.
//

import Foundation

enum LoginAPI: CommonService {
    case login(model: LoginRequestModel)
    
    var method: HTTPMethod {
        return .post
    }
    
    var path: String {
        switch self {
        case .login:
            return "v1/authentication/client/login"
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .login(let model):
            return model.dictionary
        }
    }
    
    var analyticsName: String {
        return .empty
    }
}

//
//  AuthInterceptor.swift
//  Blanball
//
//  Created by Misha Deneka on 09.03.2023.
//

import Foundation

protocol AuthorizationInterceptor: AnyObject {
    var authToken: String { get }
}

final class AuthorizationInterceptorImpl: NSObject {}



extension AuthorizationInterceptorImpl: AuthorizationInterceptor {
    var authToken: String {
        return .empty
    }
}


extension AuthorizationInterceptorImpl: URLSessionTaskDelegate {
    
}

extension AuthorizationInterceptorImpl: URLSessionDataDelegate {
    
}

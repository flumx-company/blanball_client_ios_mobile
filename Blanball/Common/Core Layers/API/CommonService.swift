//
//  CommonService.swift
//  Blanball
//
//  Created by Misha Deneka on 01.03.2023.
//

import Foundation

public protocol CommonService {
    
    /**
     Method for service
     */
    var method: HTTPMethod { get }
    
    /**
     Path for service
     */
    var path: String { get }
    
    /**
     Parameters for service
     */
    var parameters: [String: Any]? { get }
    
    /**
     Headers for service
     */
    var headers: [String: String]? { get }
    
    /**
     Headers for service
     */
    var timeoutInterval: TimeInterval { get }
    
    /**
     Path for service
     */
    var host: String { get }
    
    /**
     Use for tracking network event in analytics
     */
    var analyticsName: String { get }
    
    /**
     Used for sending additional parameters during network event tracking in analytics
     */
    var analyticsAdditionalParameters: String? { get }
    
}

extension CommonService {
    func asURLRequest() throws -> URLRequest {
        guard let url = URL(string: host)?.appendingPathComponent(path) else {
            throw NetworkError.badUrl
        }
        var mutableURLRequest = URLRequest(url: url)

        mutableURLRequest.httpMethod = method.rawValue
        mutableURLRequest.timeoutInterval = timeoutInterval
        if let headers = headers {
            for (key, value) in headers {
                mutableURLRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        if let url = mutableURLRequest.url {
            print("REQUEST: \(method.rawValue) \(url)")
            print("Request headers: \(mutableURLRequest.allHTTPHeaderFields ?? [:])")
            if let parameters = parameters {
               print("Request data: \(parameters)")
            }
        }
        
        if let parameters = parameters {
            encodeParamsForRequest(
                request: &mutableURLRequest,
                with: parameters
            )
            return mutableURLRequest
        } else {
            return mutableURLRequest
        }
    }
    
    func encodeParamsForRequest(
        request: inout URLRequest,
        with params: [String: Any]
    ) {
        switch method {
        case .post, .put, .delete, .patch:
            let jsonData = try? JSONSerialization.data(withJSONObject: params)
            request.httpBody = jsonData
        case .get:
            let queryItems = params.map { key, value in
                URLQueryItem(name: key, value: "\(value)")
            }
            var components = URLComponents(
                url: request.url!,
                resolvingAgainstBaseURL: false
            )
            components?.queryItems = queryItems
            request.url = components?.url
        default:
            let jsonData = try? JSONSerialization.data(withJSONObject: params)
            request.httpBody = jsonData
        }
    }
}

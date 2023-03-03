//
//  NetworkError.swift
//  Blanball
//
//  Created by Misha Deneka on 01.03.2023.
//

import Foundation

enum NetworkError: Error {
    case noData
    case anotherError(String, Error)
    case badUrl
    case processableError(Error)
    case invalidResponse
    case wrongStatusCode(_ statusCode: Int)
    case noInternet
}

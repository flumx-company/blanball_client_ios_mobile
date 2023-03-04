//
//  EnviromentVars.swift
//  Blanball
//
//  Created by Misha Deneka on 03.03.2023.
//

import Foundation

private struct EnvironmentKeys {
    static let apiBaseURL = "ApiBaseURL"
    static let configuration = "Configuration"
    static let scheme = "Scheme"
    static let isInDebug = "IsInDebug"
}

struct EnvironmentVars {
    static let isInDebug: Bool = {
        let value = Bundle.main.infoDictionary?[EnvironmentKeys.isInDebug] as? String ?? "NO"
        return value == "YES"
    }()

    static let configuration: String = {
        let value = Bundle.main.infoDictionary?[EnvironmentKeys.configuration] as? String ?? "test"
        return value
    }()
    
    static let scheme: String = {
        let value = Bundle.main.infoDictionary?[EnvironmentKeys.scheme] as? String ?? "test"
            return value
    }()
    
    static let baseApiHost: String = {
        let value = Bundle.main.infoDictionary?[EnvironmentKeys.apiBaseURL] as? String ?? ""
        return value
    }()

    static let webSocketApiHost: String = {
        return "ws://\(baseApiHost)/"
    }()
    
    static let apiHost: String = {
        return "https://\(baseApiHost)/api/"
    }()
}

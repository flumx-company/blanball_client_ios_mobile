//
//  CommonService+Default.swift
//  Blanball
//
//  Created by Misha Deneka on 03.03.2023.
//

import Foundation

extension CommonService {
    var host: String {
        return EnvironmentVars.apiHost
    }

    var timeoutInterval: TimeInterval {
        return 30
    }
    
    var headers: [String: String]? {
        return [
            "App-Version": AppConstants.App.appVersion,
            "Platform-Type": AppConstants.App.platform,
            "Platform-Version": AppConstants.App.iOSVersion
        ]
    }
    
    var analyticsAdditionalParameters: String? {
        return nil
    }
}

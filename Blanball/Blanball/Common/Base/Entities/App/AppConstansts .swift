//
//  AppConstansts.swift
//  Blanball
//
//  Created by Misha Deneka on 03.03.2023.
//

import Foundation
import UIKit

struct AppConstants {
    struct App {
        static let appVersion: String = {
            let infoDictionary = Bundle.main.infoDictionary! // swiftlint:disable:this force_unwrapping
            let majorVersion = infoDictionary["CFBundleShortVersionString"]! // swiftlint:disable:this force_unwrapping
            let minorVersion = infoDictionary["CFBundleVersion"]! // swiftlint:disable:this force_unwrapping
            
            return "\(majorVersion).\(minorVersion)"
        }()
        
        static let appShortVersion: String = {
            let infoDictionary = Bundle.main.infoDictionary! // swiftlint:disable:this force_unwrapping
            let majorVersion = infoDictionary["CFBundleShortVersionString"]! // swiftlint:disable:this force_unwrapping
            
            return "\(majorVersion)"
        }()
        
        
        static var iOSVersion: String {
            return UIDevice.current.systemVersion
        }
        
        static let platform = "iOS"
    }
}

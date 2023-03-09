//
//  StorageKEy.swift
//  Blanball
//
//  Created by Misha Deneka on 09.03.2023.
//

import Foundation

enum StorageKey: String, CaseIterable {
    case didUserWatchOnboarding = "kDidUserWatchOnboarding"
    case accessToken = "kJWTAccessToken"
    case refreshToken = "kJWTRefreshToken"
    case randomKey = "kRandomKey"
    
    static var deletableKeys: [StorageKey] {
        return []
    }
}

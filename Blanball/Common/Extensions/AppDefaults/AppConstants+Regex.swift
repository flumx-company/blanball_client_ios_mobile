//
//  AppConstants+Regex.swift
//  Blanball
//
//  Created by Nik Dub on 06.03.2023.
//

import Foundation

extension AppConstants {
    enum Regex {
        static let email = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"#
        static let password = #"^[A-Z0-9a-z]{6,30}"#
        static let phoneNumber = #"^\+?[0-9]{1,3}[0-9]{3}[0-9]{3}[0-9]{4}$"#
    }
}

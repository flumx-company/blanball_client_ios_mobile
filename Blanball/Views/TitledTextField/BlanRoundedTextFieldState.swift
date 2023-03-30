//
//  TitledTextFieldState.swift
//  Blanball
//
//  Created by Nik Dub on 06.03.2023.
//

import Foundation

enum TitledTextFieldState {
    case idle
    case updated(value: String?, isValid: Bool)
}

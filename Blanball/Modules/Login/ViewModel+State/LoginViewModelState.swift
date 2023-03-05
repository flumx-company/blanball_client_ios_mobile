//
//  LoginViewModelState.swift
//  Blanball
//
//  Created by Nikita Dubovik on 05.03.2023.
//

import Foundation

enum LoginViewModelState: ViewModelState {
    case started
    case failure(error: Error)
    case loading
    case updated
}

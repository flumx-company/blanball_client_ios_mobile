//
//  ResetPasswordViewModelState.swift
//  Blanball
//
//  Created by Nik Dub on 24.03.2023.
//

import Foundation

enum ResetPasswordViewModelState: ViewModelState {
    case started
    case failure(error: Error)
    case loading
    case updated
}

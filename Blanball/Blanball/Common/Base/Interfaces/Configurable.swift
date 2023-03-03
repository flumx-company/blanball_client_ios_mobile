//
//  Configurable.swift
//  Blanball
//
//  Created by Misha Deneka on 01.03.2023.
//

import Foundation

protocol Configurable {
    associatedtype Model
    /// Configures object with given model.
    func configure(with model: Model)
}

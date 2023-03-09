//
//  StorageContainer.swift
//  Blanball
//
//  Created by Misha Deneka on 09.03.2023.
//

import Foundation

struct StorageContainer<T>: Codable where T: Codable {
    let value: T
}

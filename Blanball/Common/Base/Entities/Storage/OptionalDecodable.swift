//
//  OptionalDecodable.swift
//  Blanball
//
//  Created by Misha Deneka on 09.03.2023.
//

import Foundation

struct OptionalDecodable<Value: Decodable>: Decodable {
    let value: Value?

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        do {
            let value = try container.decode(Value.self)
            self.value = value
        } catch let error {
            print("OptionalDecodable error: \(error)")
            value = nil
        }
    }
}

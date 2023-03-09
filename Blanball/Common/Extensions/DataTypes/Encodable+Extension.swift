//
//  Encodable+Extension.swift
//  Blanball
//
//  Created by Misha Deneka on 05.03.2023.
//

import Foundation

extension Encodable {
    var dictionary: [String: Any]? {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        guard let data = try? encoder.encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}

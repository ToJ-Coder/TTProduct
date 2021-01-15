//
//  TTModelConvertible.swift
//  TTProduct
//
//  Created by Toj on 1/15/21.
//

import Foundation

extension Encodable {
    
    var tt_dictionary: [String: Any] {
        guard let data = tt_data else {return [:]}
        return (try? JSONSerialization.jsonObject(with: data)) as? [String: Any] ?? [:]
    }
    
    subscript(key: String) -> Any? {
        return tt_dictionary[key]
    }
    
    var tt_data: Data? {
        return try? JSONEncoder().encode(self)
    }
    
    var tt_json: String? {
        guard let data = tt_data else {return nil}
        return String(data: data, encoding: .utf8)
    }
}

extension Decodable {
    static func tt_model(data: Data) -> Self? {
        return try? JSONDecoder().decode(self, from: data)
    }
    
    static func tt_model(json string: String) -> Self? {
        guard let data = string.data(using: .utf8) else {return nil}
        return tt_model(data: data)
    }
    
    static func tt_model<Key: Hashable,Value>(dict: Dictionary<Key,Value>) -> Self? {
        guard let data = try? JSONSerialization.data(withJSONObject: dict, options: .fragmentsAllowed) else {return nil}
        return tt_model(data: data)
    }
}

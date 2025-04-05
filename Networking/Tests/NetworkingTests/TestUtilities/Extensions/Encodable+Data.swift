//
//  Encodable+Data.swift
//  Networking
//
//  Created by Kyle Haptonstall on 4/5/25.
//

import Foundation

extension Encodable {
    func asData(encoder: JSONEncoder = .init()) throws -> Data {
        try encoder.encode(self)
    }
}

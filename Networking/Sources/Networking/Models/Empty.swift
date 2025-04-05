//
//  Empty.swift
//  Networking
//
//  Created by Kyle Haptonstall on 4/5/25.
//

import Foundation

/// A convenience type used to represent empty `Codable` types.
public struct Empty: Codable, Sendable {
    public static let value = Empty()
}

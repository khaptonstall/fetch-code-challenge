//
//  File.swift
//  Recipes
//
//  Created by Kyle Haptonstall on 4/5/25.
//

import Foundation
import RecipesAPI

extension Recipe: Identifiable {
    public var id: String { uuid }
}

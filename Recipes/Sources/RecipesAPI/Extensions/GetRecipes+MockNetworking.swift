//
//  GetRecipes+MockNetworking.swift
//  Recipes
//
//  Created by Kyle Haptonstall on 4/6/25.
//

#if canImport(MockNetworking)

import Foundation
import Networking
import MockNetworking

/// Convenience methods for mocking the `GetRecipes` request.
public extension MockNetworkTaskHandler {
    func mockGetRecipes(
        statusCode: Int = 200,
        recipes: [Recipe] = []
    ) throws {
        let data = try JSONEncoder.default.encode(GetRecipesResponse(recipes: recipes))
        mockRequest(
            httpMethod: .get,
            host: RecipesAPI.host,
            path: "/recipes.json",
            statusCode: statusCode,
            data: data
        )
    }
}

#endif

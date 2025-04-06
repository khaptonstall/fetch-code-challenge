//
//  GetRecipes.swift
//  Recipes
//
//  Created by Kyle Haptonstall on 4/5/25.
//

import Foundation
import Networking

/// Network request used to fetch a list of `Recipe` objects.
public struct GetRecipes: NetworkRequest {
    // MARK: Properties

    public let responseValidators: [URLResponseValidator] = [StatusCodeValidator()]

    private let url: String

    init(url: String = "\(RecipesAPI.baseURL)/recipes.json") {
        self.url = url
    }

    public func makeRequest() throws -> URLRequest {
        return try URLRequest.makeRequest(
            url: url,
            method: .get
        )
    }
    
    public func parseResponse(data: Data) throws -> [Recipe] {
        let response = try JSONDecoder.default.decode(GetRecipesResponse.self, from: data)
        return response.recipes
    }
}

// MARK: - Get Recipes Response

struct GetRecipesResponse: Codable {
    let recipes: [Recipe]
}

// MARK: - Utilities

public extension GetRecipes {
    /// The standard network request used to fetch a list of recipes.
    static let `default` = GetRecipes()

    /// Test utility that will returned malformed recipe data.
    static let malformed = GetRecipes(url: "\(RecipesAPI.baseURL)/recipes-malformed.json")

    /// Test utility that will return an empty list of recipes.
    static let empty = GetRecipes(url: "\(RecipesAPI.baseURL)/recipes-empty.json")
}

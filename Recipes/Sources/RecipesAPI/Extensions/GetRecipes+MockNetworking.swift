// Copyright © 2025 Kyle Haptonstall. All rights reserved.

#if canImport(MockNetworking)

    import Foundation
    import MockNetworking
    import Networking

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

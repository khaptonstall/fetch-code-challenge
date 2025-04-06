// Copyright © 2025 Kyle Haptonstall. All rights reserved.

import Foundation
import Networking

/// An object used to interact with the Recipe API.
public final class RecipesAPI: Sendable {
    // MARK: Properties

    public static let shared = RecipesAPI()

    static let baseURL = "https://\(host)"
    static let host = "d3jbb8n5wk0qxi.cloudfront.net"
    private let requestPerformer: NetworkRequestPerformer

    // MARK: Initialization

    init(requestPerformer: NetworkRequestPerformer = .init()) {
        self.requestPerformer = requestPerformer
    }

    // MARK: APIs

    /// Performs a network request and attempts to fetch a list of recipes.
    /// - Parameter networkRequest: The underlying `GetRecipes` request to perform.
    public func getRecipes(_ networkRequest: GetRecipes = .default) async throws -> GetRecipes.ResponseDataType {
        try await requestPerformer.performRequest(networkRequest)
    }
}

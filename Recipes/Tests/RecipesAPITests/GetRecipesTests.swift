//
//  GetRecipesTests.swift
//  Recipes
//
//  Created by Kyle Haptonstall on 4/5/25.
//

import Foundation
@testable import RecipesAPI
import MockNetworking
import Networking
import XCTest

final class GetRecipesTests: XCTestCase {

    func testGetRecipesWithValidData() async throws {
        // Setup a mocked Recipes API instance
        let mockTaskHandler = MockNetworkTaskHandler()
        let requestPerformer = NetworkRequestPerformer(taskHandler: mockTaskHandler)
        let recipesAPI = RecipesAPI(requestPerformer: requestPerformer)

        // Mock the get recipes API with a valid response
        let expectedRecipe = Recipe.minimalData
        try await mockTaskHandler.mockGetRecipes(recipes: [expectedRecipe])

        // Perform the network request and validate the response
        let response = try await recipesAPI.getRecipes()
        XCTAssertEqual(response, [expectedRecipe])
    }

}

//
//  RecipeListViewModelTests.swift
//  Recipes
//
//  Created by Kyle Haptonstall on 4/6/25.
//

import Combine
import Foundation
import MockNetworking
import Networking
@testable import RecipesAPI
@testable import RecipesUI
import XCTest

final class RecipeListViewModelTests: XCTestCase {

    // MARK: Properties

    private var subscriptions: Set<AnyCancellable> = []

    // MARK: Lifecycle

    override func tearDown() {
        super.tearDown()
        self.subscriptions = []
    }

    // MARK: Tests

    /// Verifies the recipes array will be updated after successfully fetching recipes from the network.
    @MainActor
    func testRecipesUpdatesOnGetRecipesSuccess() async throws {
        // Setup a mock RecipesAPI
        let mockTaskHandler = MockNetworkTaskHandler()
        let requestPerformer = NetworkRequestPerformer(taskHandler: mockTaskHandler)
        let recipesAPI = RecipesAPI(requestPerformer: requestPerformer)

        // Mock the request to get recipes with a successful response
        let recipe = Recipe.Previews.withPhoto
        try await mockTaskHandler.mockGetRecipes(recipes: [recipe])

        // Setup a view model with our mocked RecipesAPI and fetch the recipes
        let viewModel = RecipeListViewModel(recipesAPI: recipesAPI)
        XCTAssertTrue(viewModel.recipes.isEmpty)
        await viewModel.getRecipes()

        // Verify the recipes array was updated
        XCTAssertEqual(viewModel.recipes, [recipe])
    }

    /// Verifies the state transitions which take place on successfully fetching recipes.
    @MainActor
    func testStateUpdatesOnGetRecipesSuccess() async throws {
        // Setup a mock RecipesAPI
        let mockTaskHandler = MockNetworkTaskHandler()
        let requestPerformer = NetworkRequestPerformer(taskHandler: mockTaskHandler)
        let recipesAPI = RecipesAPI(requestPerformer: requestPerformer)

        // Mock the request to get recipes with a successful response
        try await mockTaskHandler.mockGetRecipes()

        // Setup a view model with our mocked RecipesAPI
        let viewModel = RecipeListViewModel(recipesAPI: recipesAPI)

        // Verify the state will update from .loading -> .loaded
        await assertStateUpdates(on: viewModel, expecting: [.loading, .loaded]) {
            await viewModel.getRecipes()
        }
    }

    /// Verifies the state transitions which take place on failing to fetch recipes.
    @MainActor
    func testStateUpdatesOnGetRecipesFails() async throws {
        // Setup a mock RecipesAPI
        let mockTaskHandler = MockNetworkTaskHandler()
        let requestPerformer = NetworkRequestPerformer(taskHandler: mockTaskHandler)
        let recipesAPI = RecipesAPI(requestPerformer: requestPerformer)

        // Mock the request to get recipes with a failure response
        try await mockTaskHandler.mockGetRecipes(statusCode: 500)

        // Setup a view model with our mocked RecipesAPI
        let viewModel = RecipeListViewModel(recipesAPI: recipesAPI)

        // Verify the state will update from .loading -> .error
        await assertStateUpdates(on: viewModel, expecting: [.loading, .error(message: "Response validation failed")]) {
            await viewModel.getRecipes()
        }
    }
}

// MARK: - Utilities

private extension RecipeListViewModelTests {
    /// Utility method to observe and assert state updates occur on a specific `trigger`.
    /// Note that the initial state will be ignored.
    @MainActor
    func assertStateUpdates(
        on viewModel: RecipeListViewModel,
        expecting expectedStates: [RecipeListViewModel.State],
        trigger: () async -> Void
    ) async {
        // Setup an expectation that the state get updated
        let stateExpectation = expectation(description: "State has been updated")
        stateExpectation.expectedFulfillmentCount = expectedStates.count

        // Observe the state updates the view model goes through
        var stateUpdates: [RecipeListViewModel.State] = []
        viewModel.$state
            .dropFirst() // Ignore the initial state
            .sink { state in
                stateUpdates.append(state)
                stateExpectation.fulfill()
        }
        .store(in: &subscriptions)

        // Trigger state updates
        await trigger()

        await fulfillment(of: [stateExpectation], timeout: 1)
        XCTAssertEqual(stateUpdates, expectedStates)
    }
}




// Copyright © 2025 Kyle Haptonstall. All rights reserved.

import Foundation
import RecipesAPI
import SwiftUI

/// A view model for the `RecipesList`.
@MainActor
class RecipeListViewModel: ObservableObject {
    enum State: Equatable {
        /// An initial, placeholder view model state.
        case none
        /// Represents the view model loading data from the network.
        case loading
        /// Represents that the view model has finished loading data from the network successfully.
        case loaded
        /// Represents that the view model has finished loading but encountered an error.
        case error(message: String)
    }

    // MARK: - Properties

    @Published fileprivate(set) var recipes: [Recipe] = []
    @Published fileprivate(set) var state: State = .none

    private let recipesAPI: RecipesAPI

    // MARK: Initialization

    init(recipesAPI: RecipesAPI = .shared) {
        self.recipesAPI = recipesAPI
    }

    // MARK: API

    func getRecipes() async {
        guard state != .loading else { return }

        do {
            state = .loading
            recipes = try await recipesAPI.getRecipes(.default)
            state = .loaded
        } catch {
            state = .error(message: error.localizedDescription)
        }
    }
}

// MARK: - Preview Support

#if DEBUG
    class PreviewRecipeListViewModel: RecipeListViewModel {
        init(recipes: [Recipe] = [], state: State = .none) {
            super.init()

            self.recipes = recipes
            self.state = state
        }

        override func getRecipes() async {}
    }
#endif

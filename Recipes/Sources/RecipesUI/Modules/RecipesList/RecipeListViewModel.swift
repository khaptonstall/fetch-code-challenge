//
//  RecipeListViewModel.swift
//  Recipes
//
//  Created by Kyle Haptonstall on 4/5/25.
//

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
        guard self.state != .loading else { return }

        do {
            self.state = .loading
            self.recipes = try await recipesAPI.getRecipes(.default)
            self.state = .loaded
        } catch {
            self.state = .error(message: error.localizedDescription)
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

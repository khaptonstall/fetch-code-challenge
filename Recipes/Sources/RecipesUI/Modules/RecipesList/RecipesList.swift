//
//  RecipesList.swift
//  Recipes
//
//  Created by Kyle Haptonstall on 4/5/25.
//

import SwiftUI
import RecipesAPI

/// A view used to fetch and display a list of recipes.
public struct RecipesList: View {
    // MARK: Properties

    @StateObject private var viewModel = RecipeListViewModel()
    @State private var getRecipesTaskID = UUID().uuidString

    public var body: some View {
        ZStack {
            List(viewModel.recipes) { recipe in
                RecipeItem(
                    cuisine: recipe.cuisine,
                    recipeName: recipe.name,
                    photoURL: recipe.smallPhotoURL
                )
            }
            .refreshable(action: triggerRecipesReload)

            switch viewModel.state {
            case .none, .loading:
                LoadingView()
            case .error(let message):
                RecipeContentUnavailableView
                    .error(
                        message,
                        tryAgainAction: triggerRecipesReload
                    )
            case .loaded:
                RecipeContentUnavailableView
                    .noResults(tryAgainAction: triggerRecipesReload)
                    .opacity(viewModel.recipes.isEmpty ? 1 : 0)
            }
        }
        .task(id: getRecipesTaskID) {
            await viewModel.getRecipes()
        }
        .navigationTitle("Recipes")
    }

    // MARK: Initialization

    public init() {}

    // MARK: Actions

    private func triggerRecipesReload() {
        getRecipesTaskID = UUID().uuidString
    }
}

// MARK: - Supporting Types

private struct LoadingView: View {
    var body: some View {
        List {
            RecipeItem.placeholder
            RecipeItem.placeholder
        }
    }
}

// MARK: - Previews

#if DEBUG
private extension RecipesList {
    init(recipes: [Recipe], state: RecipeListViewModel.State) {
        self._viewModel = StateObject(
            wrappedValue: PreviewRecipeListViewModel(recipes: recipes, state: state)
        )
    }
}
#endif

#Preview("Loaded") {
    NavigationStack {
        RecipesList(
            recipes: [
                .Previews.withPhoto,
                .Previews.withoutPhoto,
            ],
            state: .loaded
        )
    }
}

#Preview("Loading") {
    RecipesList(recipes: [], state: .loading)
}

#Preview("Error") {
    RecipesList(recipes: [], state: .error(message: "Error message"))
}

#Preview("Empty Network Response") {
    RecipesList(recipes: [], state: .loaded)
}

#Preview("Live Data") {
    RecipesList()
}

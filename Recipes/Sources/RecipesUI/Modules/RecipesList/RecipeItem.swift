//
//  RecipeItem.swift
//  Recipes
//
//  Created by Kyle Haptonstall on 4/5/25.
//

import SwiftUI

// TODO: Load asset from `photoURL`

/// Used to display a single recipe in a list-style view.
struct RecipeItem: View {

    let cuisine: String
    let recipeName: String
    let photoURL: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(recipeName)
                .multilineTextAlignment(.leading)
                .font(.headline)
                .foregroundStyle(.primary)

            Text(cuisine)
                .multilineTextAlignment(.leading)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - RecipeItem + Placeholder

extension RecipeItem {
    /// A placehold `RecipeItem` that can be used to represent loading states.
    @ViewBuilder
    static var placeholder: some View {
        RecipeItem(
            cuisine: "British",
            recipeName: "Bakewell Tart",
            photoURL: nil
        )
        .redacted(reason: .placeholder)
    }
}

// MARK: - Previews

#Preview {
    List {
        RecipeItem.Previews.withoutPhoto
        RecipeItem.Previews.withPhoto
    }
}

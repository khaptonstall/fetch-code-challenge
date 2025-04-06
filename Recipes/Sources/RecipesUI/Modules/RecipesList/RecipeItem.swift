//
//  RecipeItem.swift
//  Recipes
//
//  Created by Kyle Haptonstall on 4/5/25.
//

import RemoteImage
import SwiftUI

// TODO: Load asset from `photoURL`

/// Used to display a single recipe in a list-style view.
struct RecipeItem: View {

    let cuisine: String
    let recipeName: String
    let photoURL: String?

    var body: some View {
        HStack {
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

            Spacer()

            if let photoURLString = photoURL, let url = URL(string: photoURLString) {
                RemoteImage(url: url)
                    .frame(width: 75, height: 75)
                    .cornerRadius(8)
                    .accessibilityHidden(true)
            }
        }
        .contentShape(Rectangle())
        .accessibilityElement(children: .combine)
    }
}

// MARK: - RecipeItem + Placeholder

extension RecipeItem {
    /// A placeholder `RecipeItem` that can be used to represent loading states.
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

// Copyright © 2025 Kyle Haptonstall. All rights reserved.

import Foundation
import SwiftUI

/// An interface, consisting of a label and additional content, that you display when the content of your app is unavailable to users.
struct RecipeContentUnavailableView<
    Label: View,
    Description: View,
    Actions: View
>: View {
    // MARK: Properties

    let label: Label
    let description: Description
    let actions: Actions

    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            label
            description
            actions
        }
        .padding()
    }

    // MARK: Initialization

    fileprivate init(
        @ViewBuilder label: () -> Label,
        @ViewBuilder description: () -> Description,
        @ViewBuilder actions: () -> Actions
    ) {
        self.label = label()
        self.description = description()
        self.actions = actions()
    }
}

// MARK: - Default Implementations

extension RecipeContentUnavailableView where Label == IconLabel, Description == DescriptionLabel, Actions == Button<Text> {
    /// A view variation for informing the user there are no results to display.
    /// - Parameter tryAgainAction: An action triggered when the user taps a button to try the action again.
    @ViewBuilder
    static func noResults(tryAgainAction: @escaping () -> Void) -> some View {
        RecipeContentUnavailableView {
            IconLabel(systemImage: "questionmark.folder", text: "No results")
        } description: {
            DescriptionLabel(text: "We didn't find any recipes this time. Try again later.")
        } actions: {
            Button(action: tryAgainAction) {
                Text("Try Again")
            }
        }
    }

    /// A view variation for informing the user an error occurred.
    /// - Parameter tryAgainAction: An action triggered when the user taps a button to try the action again.
    @ViewBuilder
    static func error(_ message: String, tryAgainAction: @escaping () -> Void) -> some View {
        RecipeContentUnavailableView {
            IconLabel(systemImage: "xmark.icloud", text: "Error")
        } description: {
            DescriptionLabel(text: message)
        } actions: {
            Button(action: tryAgainAction) {
                Text("Try Again")
            }
        }
    }
}

// MARK: - Supporting Types

/// Viewed used to display a vertical stack consisting of a system icon and title text in a `RecipeContentUnavailableView`.
struct IconLabel: View {
    let systemImage: String
    let text: String

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: systemImage)
                .font(.system(size: 64))
                .foregroundStyle(.tertiary)
            Text(text)
                .multilineTextAlignment(.center)
                .font(.title)
                .fontWeight(.semibold)
        }
    }

    fileprivate init(systemImage: String, text: String) {
        self.systemImage = systemImage
        self.text = text
    }
}

/// Viewed used to display a stylized description label for a `RecipeContentUnavailableView`.
struct DescriptionLabel: View {
    let text: String

    var body: some View {
        Text(text)
            .multilineTextAlignment(.center)
            .font(.body)
            .foregroundStyle(.secondary)
    }

    fileprivate init(text: String) {
        self.text = text
    }
}

// MARK: = Previews

#Preview("No Results") {
    RecipeContentUnavailableView.noResults {}
}

#Preview("Error") {
    RecipeContentUnavailableView.error("An error occurred when looking up available receipes.") {}
}

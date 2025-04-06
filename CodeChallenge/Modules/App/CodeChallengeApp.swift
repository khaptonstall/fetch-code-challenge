// Copyright © 2025 Kyle Haptonstall. All rights reserved.

import RecipesUI
import SwiftUI

@main
struct CodeChallengeApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                RecipesList()
            }
        }
    }
}

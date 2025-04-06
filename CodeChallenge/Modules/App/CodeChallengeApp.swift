//
//  CodeChallengeApp.swift
//  CodeChallenge
//
//  Created by Kyle Haptonstall on 4/5/25.
//

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

//
//  RecipeItem+Previews.swift
//  Recipes
//
//  Created by Kyle Haptonstall on 4/6/25.
//

import RecipesAPI
import SwiftUI

#if DEBUG
extension RecipeItem {
    enum Previews {
        static let withoutPhoto = RecipeItem(
            cuisine: Recipe.Previews.withoutPhoto.cuisine,
            recipeName: Recipe.Previews.withoutPhoto.name,
            photoURL: nil
        )

        static let withPhoto = RecipeItem(
            cuisine: Recipe.Previews.withPhoto.cuisine,
            recipeName: Recipe.Previews.withPhoto.name,
            photoURL: Recipe.Previews.withPhoto.smallPhotoURL
        )
    }
}
#endif

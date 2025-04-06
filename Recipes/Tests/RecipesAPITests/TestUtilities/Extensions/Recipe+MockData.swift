// Copyright © 2025 Kyle Haptonstall. All rights reserved.

import Foundation
import RecipesAPI

extension Recipe {
    /// A mocked recipe with only required properties set.
    static let minimalData = Recipe(
        cuisine: "British",
        name: "Bakewell Tart",
        largePhotoURL: nil,
        smallPhotoURL: nil,
        uuid: "eed6005f-f8c8-451f-98d0-4088e2b40eb6",
        sourceURL: nil,
        youtubeURL: nil
    )
}

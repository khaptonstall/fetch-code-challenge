// Copyright © 2025 Kyle Haptonstall. All rights reserved.

import RecipesAPI

extension Recipe {
    enum Previews {
        /// Represents a `Recipe` that does not contain a photo.
        static let withoutPhoto = Recipe(
            cuisine: "British",
            name: "Bakewell Tart",
            largePhotoURL: nil,
            smallPhotoURL: nil,
            uuid: "1",
            sourceURL: nil,
            youtubeURL: nil
        )

        /// Represents a `Recipe` that contains both a large and small photo.
        static let withPhoto = Recipe(
            cuisine: "British",
            name: "Bakewell Tart",
            largePhotoURL: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/dd936646-8100-4a1c-b5ce-5f97adf30a42/large.jpg",
            smallPhotoURL: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/dd936646-8100-4a1c-b5ce-5f97adf30a42/small.jpg",
            uuid: "2",
            sourceURL: nil,
            youtubeURL: nil
        )
    }
}

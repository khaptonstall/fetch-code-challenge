// Copyright © 2025 Kyle Haptonstall. All rights reserved.

import Foundation

public struct Recipe: Codable, Sendable {
    // MARK: CodingKeys

    private enum CodingKeys: String, CodingKey {
        case cuisine
        case name
        case smallPhotoURL = "photo_url_small"
        case largePhotoURL = "photo_url_large"
        case uuid
        case sourceURL = "source_url"
        case youtubeURL = "youtube_url"
    }

    // MARK: Properties

    /// The cuisine of the recipe. (e.g. "British")
    public let cuisine: String

    /// The name of the recipe. (e.g. "Bakewell Tart")
    public let name: String

    /// The URL of the recipes’s full-size photo.
    public let largePhotoURL: String?

    /// The URL of the recipes’s small photo. Useful for list view.
    public let smallPhotoURL: String?

    /// The unique identifier for the receipe. Represented as a UUID.
    public let uuid: String

    /// The URL of the recipe's original website.
    public let sourceURL: String?

    /// The URL of the recipe's YouTube video.
    public let youtubeURL: String?

    // MARK: Initialization

    public init(
        cuisine: String,
        name: String,
        largePhotoURL: String?,
        smallPhotoURL: String?,
        uuid: String,
        sourceURL: String?,
        youtubeURL: String?
    ) {
        self.cuisine = cuisine
        self.name = name
        self.largePhotoURL = largePhotoURL
        self.smallPhotoURL = smallPhotoURL
        self.uuid = uuid
        self.sourceURL = sourceURL
        self.youtubeURL = youtubeURL
    }
}

// MARK: Equatable

extension Recipe: Equatable {}

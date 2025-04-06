// Copyright © 2025 Kyle Haptonstall. All rights reserved.

import Foundation
import UIKit

actor ImageCache {
    typealias URLString = NSString

    enum DataError: Error {
        /// Occurs when the data downloaded from the server does not represent a valid image object
        case invalidImage
    }

    // MARK: Properties

    static let shared = ImageCache()

    /// Cache used to store downloaded image data.
    private let cache: NSCache<URLString, CacheEntryObject> = NSCache()

    // MARK: Initialization

    private init() {}

    // MARK: Caching

    func image(from url: URL) async throws -> Data {
        // Check for a previously cached image or an in-flight download
        if let cached = cache[url] {
            switch cached {
            case let .inProgress(task):
                return try await task.value
            case let .ready(image):
                return image
            }
        }

        // If no previous cached image or in-flight request, kick off a task to download it
        let task = Task<Data, Error> {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard UIImage(data: data) != nil else {
                throw DataError.invalidImage
            }
            return data
        }

        // Store the Task in the cache to avoid kicking of multiple requests for the same resource
        cache[url] = .inProgress(task)
        do {
            let imageData = try await task.value
            cache[url] = .ready(image: imageData)
            return imageData
        } catch {
            // Clear the cache on failure so we can re-attempt the download later
            cache[url] = nil
            throw error
        }
    }
}

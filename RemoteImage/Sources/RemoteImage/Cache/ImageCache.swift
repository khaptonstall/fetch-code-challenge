
//
//  ImageCache.swift
//  RemoteImage
//
//  Created by Kyle Haptonstall on 4/6/25.
//

import Foundation
import UIKit

actor ImageCache {
    enum DataError: Error {
        /// Occurs when the data downloaded from the server does not represent a valid image object
        case invalidImage
    }

    // MARK: Properties

    static let shared = ImageCache()

    /// Cache used to store downloaded image data.
    /// Key == a url
    private let cache: NSCache<NSString, CacheEntryObject> = NSCache()

    // MARK: Initialization

    private init() {}
    
    // MARK: Caching

    func image(from url: URL) async throws -> Data {
        // Check for a previously cached image or an in-flight download
        if let cached = cache[url] {
            switch cached {
            case .inProgress(let task):
                return try await task.value
            case .ready(let image):
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

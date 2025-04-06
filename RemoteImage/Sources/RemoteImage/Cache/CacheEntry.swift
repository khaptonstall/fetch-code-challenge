//
//  CacheEntry.swift
//  RemoteImage
//
//  Created by Kyle Haptonstall on 4/6/25.
//

import Foundation

/// Represents the state of an image in the cache.
enum CacheEntry {
    /// Represents a currently in-flight task to download the image.
    case inProgress(Task<Data, Error>)
    /// Represents a successfully fetched image.
    case ready(image: Data)
}

/// An object wrapper around `CacheEntry` that enables storage in `NSCache`.
final class CacheEntryObject {
    let entry: CacheEntry

    init(entry: CacheEntry) {
        self.entry = entry
    }
}

// MARK: - NSCache + CacheEntry

extension NSCache where KeyType == NSString, ObjectType == CacheEntryObject {
    subscript(_ url: URL) -> CacheEntry? {
        get {
            // Check for an existing entry for a given URL
            let key = url.absoluteString as NSString
            let value = object(forKey: key)
            return value?.entry
        }
        set {
            let key = url.absoluteString as NSString
            if let entry = newValue {
                // If we got a new cache entry, save it
                let value = CacheEntryObject(entry: entry)
                setObject(value, forKey: key)
            } else {
                // Otherwise, clear out any existing entry
                removeObject(forKey: key)
            }
        }
    }
}

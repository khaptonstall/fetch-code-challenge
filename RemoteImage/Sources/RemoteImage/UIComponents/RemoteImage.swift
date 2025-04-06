// Copyright © 2025 Kyle Haptonstall. All rights reserved.

import Foundation
import SwiftUI

/// A variation of `Image` which will download and cache remote images.
public struct RemoteImage: View {
    // MARK: Properties

    private let url: URL
    @State private var imageData: Data?

    public var body: some View {
        VStack {
            if let imageData {
                Image(data: imageData)
                    .resizable()
            } else {
                ProgressView()
            }
        }
        .task {
            do {
                imageData = try await ImageCache.shared.image(from: url)
            } catch {
                // TODO: Handle error (e.g. allow user to set an error fallback image)
            }
        }
    }

    // MARK: Initialization

    public init(url: URL) {
        self.url = url
    }
}

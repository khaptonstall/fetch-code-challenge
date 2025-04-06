// Copyright © 2025 Kyle Haptonstall. All rights reserved.

import Foundation
import SwiftUI
import UIKit

extension Image {
    init(data: Data) {
        let uiImage = UIImage(data: data) ?? UIImage()
        self.init(uiImage: uiImage)
    }
}

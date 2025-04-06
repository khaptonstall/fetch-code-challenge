// Copyright © 2025 Kyle Haptonstall. All rights reserved.

import Foundation
import RecipesAPI

extension Recipe: Identifiable {
    public var id: String { uuid }
}

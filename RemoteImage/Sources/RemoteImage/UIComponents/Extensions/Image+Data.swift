//
//  Image+Data.swift
//  RemoteImage
//
//  Created by Kyle Haptonstall on 4/6/25.
//

import Foundation
import SwiftUI
import UIKit

extension Image {
    init(data: Data) {
        let uiImage = UIImage(data: data) ?? UIImage()
        self.init(uiImage: uiImage)
    }
}

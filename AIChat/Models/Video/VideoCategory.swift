//
//  VideoCategory.swift
//  AIChat
//
//  Created by Danil Kazakov on 20.06.2026.
//

import Foundation

// MARK: - VideoCategory

struct VideoCategory: Identifiable, Hashable {
    let id: String
    let displayName: String

    init(id: String, displayName: String) {
        self.id = id
        self.displayName = displayName
    }

    init(rawValue: String) {
        self.id = rawValue
        if let emojiRange = rawValue.range(of: " ") {
            self.displayName = String(rawValue[emojiRange.upperBound...])
        } else {
            self.displayName = rawValue
        }
    }
}

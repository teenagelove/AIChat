//
//  VideoTemplate.swift
//  AIChat
//
//  Created by Danil Kazakov on 20.06.2026.
//

import Foundation

// MARK: - VideoTemplate

struct VideoTemplate: Identifiable, Hashable, Decodable {
    let id: Int
    let templateId: Int
    let name: String
    let category: String
    let qualities: [String]
    let duration: Int
    let previewSmall: String
    let previewLarge: String

    static func == (lhs: VideoTemplate, rhs: VideoTemplate) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

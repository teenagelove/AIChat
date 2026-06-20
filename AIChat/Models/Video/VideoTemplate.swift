//
//  VideoTemplate.swift
//  AIChat
//
//  Created by Danil Kazakov on 20.06.2026.
//

import SwiftUI

// MARK: - VideoTemplate

struct VideoTemplate: Identifiable {
    let id = UUID()
    let title: String
    let image: ImageResource
    let category: VideoCategory
}

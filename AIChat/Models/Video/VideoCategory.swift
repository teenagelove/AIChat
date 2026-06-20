//
//  VideoCategory.swift
//  AIChat
//
//  Created by Danil Kazakov on 20.06.2026.
//

// MARK: - VideoCategory

enum VideoCategory: String, CaseIterable, Identifiable {
    case popular = "Popular"
    case funny = "Funny"
    case sad = "Sad"
    case trends = "Trends"
    case drama = "Drama"
    case romance = "Romance"
    case horror = "Horror"

    var id: String { rawValue }
}

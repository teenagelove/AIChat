//
//  VideoQuality.swift
//  AIChat
//
//  Created by Danil Kazakov on 21.06.2026.
//

// MARK: - VideoQuality

enum VideoQuality: String, CaseIterable, Identifiable {
    case hd360 = "360p"
    case hd540 = "540p"
    case hd720 = "720p"
    case hd1080 = "1080p"

    var id: String { rawValue }
}

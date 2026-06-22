//
//  DolaChat.swift
//  AIChat
//
//  Created by Danil Kazakov on 20.06.2026.
//

import Foundation

// MARK: - DolaChat

struct DolaChat: Decodable, Identifiable {
    let chatId: String
    let title: String?
    let updatedAt: String
    let lastMessagePreview: String?

    var id: String { chatId }

    var date: Date? {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter.date(from: updatedAt)
    }
}

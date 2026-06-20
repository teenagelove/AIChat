//
//  DolaModels.swift
//  AIChat
//
//  Created by Danil Kazakov on 20.06.2026.
//

import Foundation

// MARK: - DolaMessageResponse

struct DolaMessageResponse: Decodable {
    let chatId: String
    let assistantMessage: String

    enum CodingKeys: String, CodingKey {
        case chatId = "chat_id"
        case assistantMessage = "assistant_message"
    }
}

// MARK: - DolaChatMessage

struct DolaChatMessage: Decodable, Identifiable {
    let role: String
    let content: String
    let createdAt: Date

    var id: Date { createdAt }

    var isUser: Bool {
        role == "user"
    }
}

// MARK: - DolaChat

struct DolaChat: Decodable, Identifiable {
    let chatId: String
    let title: String?
    let updatedAt: Date

    var id: String { chatId }
}

//
//  DolaChatMessage.swift
//  AIChat
//
//  Created by Danil Kazakov on 20.06.2026.
//

import Foundation

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

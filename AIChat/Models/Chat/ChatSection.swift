//
//  ChatSection.swift
//  AIChat
//
//  Created by Danil Kazakov on 20.06.2026.
//

import Foundation

// MARK: - ChatSection

struct ChatSection: Identifiable {
    let title: String
    let chats: [DolaChat]

    var id: String { title }
}

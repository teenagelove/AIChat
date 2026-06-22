//
//  DolaMessageResponse.swift
//  AIChat
//
//  Created by Danil Kazakov on 20.06.2026.
//

import Foundation

// MARK: - DolaMessageResponse

struct DolaMessageResponse: Decodable {
    let chatId: String
    let assistantMessage: String
}

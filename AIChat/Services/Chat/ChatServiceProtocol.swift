//
//  ChatServiceProtocol.swift
//  AIChat
//
//  Created by Danil Kazakov on 20.06.2026.
//

// MARK: - ChatServiceProtocol

protocol ChatServiceProtocol {
    func sendMessage(chatId: String, message: String, locale: String?) async throws -> DolaMessageResponse
    func getMessages(chatId: String, limit: Int?, offset: Int) async throws -> [DolaChatMessage]
    func getChats(limit: Int?, offset: Int) async throws -> [DolaChat]
}

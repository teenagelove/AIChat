//
//  ChatService.swift
//  AIChat
//
//  Created by Danil Kazakov on 20.06.2026.
//

import Foundation

// MARK: - ChatService

final class ChatService: ChatServiceProtocol {

    // MARK: - Dependencies

    private let session = URLSession.shared
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()

    // MARK: - Send Message

    func sendMessage(
        chatId: String,
        message: String,
        locale: String? = nil
    ) async throws -> DolaMessageResponse {
        let request = try SendMessageRequest(
            chatId: chatId,
            message: message,
            locale: locale
        ).build()
        let (data, response) = try await session.data(for: request)
        try validateResponse(response)
        return try decoder.decode(DolaMessageResponse.self, from: data)
    }

    // MARK: - Get Messages

    func getMessages(
        chatId: String,
        limit: Int? = nil,
        offset: Int = 0
    ) async throws -> [DolaChatMessage] {
        let request = try GetMessagesRequest(
            chatId: chatId,
            limit: limit,
            offset: offset
        ).build()
        let (data, response) = try await session.data(for: request)
        try validateResponse(response)
        return try decoder.decode([DolaChatMessage].self, from: data)
    }

    // MARK: - Get Chats

    func getChats(
        limit: Int? = nil,
        offset: Int = 0
    ) async throws -> [DolaChat] {
        let request = try GetChatsRequest(
            limit: limit,
            offset: offset
        ).build()
        let (data, response) = try await session.data(for: request)
        try validateResponse(response)
        return try decoder.decode([DolaChat].self, from: data)
    }
}

private extension ChatService {

    // MARK: - Validation

    func validateResponse(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode)
        else {
            throw URLError(.badServerResponse)
        }
    }
}

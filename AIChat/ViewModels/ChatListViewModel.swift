//
//  ChatListViewModel.swift
//  AIChat
//
//  Created by Danil Kazakov on 20.06.2026.
//

import Combine
import Foundation

// MARK: - ChatListViewModel

@MainActor
final class ChatListViewModel: ObservableObject {

    // MARK: - Published

    @Published var chats: [DolaChat] = []
    @Published var isLoading = false

    // MARK: - Dependencies

    private let chatService: any ChatServiceProtocol

    // MARK: - Init

    init(chatService: any ChatServiceProtocol) {
        self.chatService = chatService
    }

    // MARK: - Actions

    func loadChats() async {
        isLoading = true
        do {
            chats = try await chatService.getChats(limit: 50, offset: 0)
        } catch {
            print("Failed to load chats: \(error)")
        }
        isLoading = false
    }
}

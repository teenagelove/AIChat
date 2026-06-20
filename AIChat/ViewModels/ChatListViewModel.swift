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

    // MARK: - Computed

    var groupedChats: [(key: String, value: [DolaChat])] {
        let calendar = Calendar.current
        let grouped = Dictionary(grouping: chats) { chat in
            guard let date = chat.date else { return "Unknown" }
            if calendar.isDateInToday(date) {
                return "Today"
            } else if calendar.isDateInYesterday(date) {
                return "Yesterday"
            } else {
                let formatter = DateFormatter()
                formatter.dateFormat = "MMMM d"
                return formatter.string(from: date)
            }
        }
        let order = ["Today", "Yesterday"]
        return grouped.sorted { lhs, rhs in
            let lhsIndex = order.firstIndex(of: lhs.key) ?? order.count
            let rhsIndex = order.firstIndex(of: rhs.key) ?? order.count
            if lhsIndex != rhsIndex { return lhsIndex < rhsIndex }
            return lhs.key > rhs.key
        }
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

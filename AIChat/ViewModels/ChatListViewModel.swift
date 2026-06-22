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

    // MARK: - State

    enum State {
        case idle
        case loading
        case loaded([DolaChat])
        case empty
        case error(String)
    }

    // MARK: - Published

    @Published var state: State = .idle

    // MARK: - Dependencies

    private let chatService: any ChatServiceProtocol

    // MARK: - Computed

    var sections: [ChatSection] {
        guard case .loaded(let chats) = state else { return [] }
        let grouped = Dictionary(grouping: chats) { $0.date?.chatGroupKey ?? String(localized: "unknown") }
        return grouped
            .map { ChatSection(title: $0.key, chats: $0.value) }
            .sorted { lhs, rhs in
                let order = [String(localized: "today"), String(localized: "yesterday")]
                let lhsIndex = order.firstIndex(of: lhs.title) ?? order.count
                let rhsIndex = order.firstIndex(of: rhs.title) ?? order.count
                return lhsIndex != rhsIndex ? lhsIndex < rhsIndex : lhs.title > rhs.title
            }
    }

    // MARK: - Init

    init(chatService: any ChatServiceProtocol) {
        self.chatService = chatService
    }

    // MARK: - Actions

    func loadChats() async {
        state = .loading
        do {
            let chats = try await chatService.getChats(limit: 50, offset: 0)
            state = chats.isEmpty ? .empty : .loaded(chats)
        } catch {
            state = .error(error.localizedDescription)
        }
    }
}

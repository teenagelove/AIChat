//
//  ChatViewModel.swift
//  AIChat
//
//  Created by Danil Kazakov on 19.06.2026.
//

import Combine
import Foundation
import SwiftUI

// MARK: - ChatViewModel

@MainActor
final class ChatViewModel: ObservableObject {

    // MARK: - State

    enum State {
        case idle
        case loading
        case loaded([ChatMessage])
        case error(String)
    }

    // MARK: - Published

    @Published var state: State = .idle
    @Published var messageText = ""

    // MARK: - Computed

    var hasText: Bool {
        !messageText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    // MARK: - Actions

    func pasteFromClipboard() {
        guard let string = UIPasteboard.general.string else { return }
        messageText = string
    }

    func sendMessage() {
        let text = messageText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty else { return }

        messageText = ""
    }
}

// MARK: - ChatMessage

struct ChatMessage: Identifiable, Hashable {
    let id = UUID()
    let text: String
    let isUser: Bool
    let date: Date
}

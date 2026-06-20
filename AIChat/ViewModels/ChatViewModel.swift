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

    // MARK: - Published

    @Published var messages: [ChatMessage] = []
    @Published var messageText = ""
    @Published var isLoading = false
    @Published var toast: ToastState?

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

        let userMessage = ChatMessage(text: text, isUser: true, date: Date())
        messages.append(userMessage)
        messageText = ""

        generateResponse()
    }

    func copyMessage(_ message: ChatMessage) {
        UIPasteboard.general.string = message.text
        showToast(message: String(localized: "chat-copied"), isSuccess: true)
    }

    func regenerateResponse() {
        guard messages.last(where: { $0.isUser }) != nil else { return }
        messages.removeAll { !$0.isUser }
        generateResponse()
    }

    // MARK: - Private

    private func generateResponse() {
        isLoading = true
        Task {
            do {
                try await Task.sleep(for: .seconds(2))
                let aiMessage = ChatMessage(
                    text: "This is a simulated AI response. In a real app, this would come from the API.",
                    isUser: false,
                    date: Date()
                )
                messages.append(aiMessage)
                isLoading = false
            } catch {
                isLoading = false
                showToast(message: error.localizedDescription, isSuccess: false)
            }
        }
    }

    private func showToast(message: String, isSuccess: Bool) {
        toast = ToastState(message: message, isSuccess: isSuccess)
        Task {
            try? await Task.sleep(for: .seconds(2))
            toast = nil
        }
    }
}

//
//  ChatViewModel.swift
//  AIChat
//
//  Created by Danil Kazakov on 19.06.2026.
//

import Combine
import SwiftUI

// MARK: - ChatViewModel

@MainActor
final class ChatViewModel: ObservableObject {

    // MARK: - Published

    @Published var messages: [ChatMessage] = []
    @Published var messageText = ""
    @Published var isLoading = false
    @Published var toast: ToastState?

    // MARK: - Dependencies

    private let chatService: any ChatServiceProtocol

    // MARK: - Private

    private var chatId: String?

    // MARK: - Computed

    var hasText: Bool {
        !messageText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    // MARK: - Init

    init(chatService: any ChatServiceProtocol) {
        self.chatService = chatService
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

        sendToAPI(message: text)
    }

    func copyMessage(_ message: ChatMessage) {
        UIPasteboard.general.string = message.text
        showToast(message: String(localized: "chat-copied"), isSuccess: true)
    }

    func regenerateResponse() {
        guard messages.last(where: { $0.isUser }) != nil else { return }
        messages.removeAll { !$0.isUser }
        guard let lastUserText = messages.last(where: { $0.isUser })?.text else { return }
        sendToAPI(message: lastUserText)
    }
}

private extension ChatViewModel {

    // MARK: - API

    func sendToAPI(message: String) {
        isLoading = true
        let currentChatId = chatId ?? UUID().uuidString

        Task {
            do {
                let response = try await chatService.sendMessage(
                    chatId: currentChatId,
                    message: message,
                    locale: nil
                )
                chatId = response.chatId

                let aiMessage = ChatMessage(
                    text: response.assistantMessage,
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

    // MARK: - Toast

    func showToast(message: String, isSuccess: Bool) {
        toast = ToastState(message: message, isSuccess: isSuccess)
        Task {
            try? await Task.sleep(for: .seconds(2))
            toast = nil
        }
    }
}

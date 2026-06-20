//
//  ChatMessageBubble.swift
//  AIChat
//
//  Created by Danil Kazakov on 19.06.2026.
//

import SwiftUI

// MARK: - ChatMessageBubble

struct ChatMessageBubble: View {

    // MARK: - Properties

    let message: ChatMessage
    var isLoading = false
    var onCopy: (() -> Void)?
    var onRefresh: (() -> Void)?

    // MARK: - Body

    var body: some View {
        if message.isUser {
            userBubble
        } else if isLoading {
            TypingIndicatorView()
                .frame(maxWidth: .infinity, alignment: .leading)
        } else {
            aiBubble
        }
    }
}

private extension ChatMessageBubble {

    // MARK: - UI Components

    var userBubble: some View {
        Text(message.text)
            .font(.regular16)
            .foregroundStyle(.white)
            .padding(16)
            .background(LinearGradient.primaryGradient.opacity(0.9))
            .clipShape(
                UnevenRoundedRectangle(
                    topLeadingRadius: 24,
                    bottomLeadingRadius: 24,
                    bottomTrailingRadius: 0,
                    topTrailingRadius: 24
                )
            )
            .frame(maxWidth: .infinity, alignment: .trailing)
    }

    var aiBubble: some View {
        VStack(alignment: .leading, spacing: 12) {
            if message.text.hasTitle {
                VStack(alignment: .leading, spacing: 8) {
                    Text(message.text.title)
                        .font(.semiBold16)
                        .foregroundStyle(LinearGradient.primaryGradient)

                    Text(message.text.body)
                        .font(.regular16)
                        .foregroundStyle(.white.opacity(0.8))
                }
            } else {
                Text(message.text)
                    .font(.regular16)
                    .foregroundStyle(.white.opacity(0.8))
            }

            Rectangle()
                .fill(.white.opacity(0.1))
                .frame(height: 1)

            HStack {
                Button {
                    onCopy?()
                } label: {
                    Image(.copyIco)
                        .resizable()
                        .frame(width: 24, height: 24)
                }

                Spacer()

                Button {
                    onRefresh?()
                } label: {
                    Image(.refresh2Ico)
                        .resizable()
                        .frame(width: 24, height: 24)
                }
            }
            .opacity(0.5)
        }
        .padding(16)
        .background(Color.card.opacity(0.5))
        .clipShape(
            UnevenRoundedRectangle(
                topLeadingRadius: 24,
                bottomLeadingRadius: 0,
                bottomTrailingRadius: 24,
                topTrailingRadius: 24
            )
        )
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - Preview

#Preview {
    VStack(spacing: 16) {
        ChatMessageBubble(message: ChatMessage(text: "Hello!", isUser: true, date: Date()))
        ChatMessageBubble(
            message: ChatMessage(text: "Hi! How can I help you?", isUser: false, date: Date()),
            onCopy: {},
            onRefresh: {}
        )
        ChatMessageBubble(message: ChatMessage(text: "", isUser: false, date: Date()), isLoading: true)
    }
    .padding()
    .background(Color.backgroundClr)
}

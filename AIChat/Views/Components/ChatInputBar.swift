//
//  ChatInputBar.swift
//  AIChat
//
//  Created by Danil Kazakov on 19.06.2026.
//

import SwiftUI

// MARK: - ChatInputBar

struct ChatInputBar: View {

    // MARK: - Properties

    @Binding var text: String
    @FocusState.Binding var isInputFocused: Bool
    let hasText: Bool
    let onImport: () -> Void
    let onSend: () -> Void

    // MARK: - Body

    var body: some View {
        HStack(alignment: .bottom, spacing: 12) {
            ZStack(alignment: .topLeading) {
                if text.isEmpty {
                    Text(.chatAskAnythingPlaceholder)
                        .font(.regular16)
                        .foregroundStyle(.white.opacity(0.5))
                        .padding(8)
                }
                TextEditor(text: $text)
                    .font(.regular16)
                    .scrollContentBackground(.hidden)
                    .focused($isInputFocused)
                    .frame(minHeight: 40, maxHeight: 120)
            }

            actionButton
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.card.opacity(0.7))
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .strokeBorder(LinearGradient.primaryGradient.opacity(0.3), lineWidth: 1)
        )
    }
}

private extension ChatInputBar {

    // MARK: - UI Components

    @ViewBuilder
    var actionButton: some View {
        if hasText {
            Button(action: onSend) {
                Image(.send2Ico)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(.white)
                    .padding(8)
                    .background(LinearGradient.primaryGradient)
                    .clipShape(Circle())
            }
        } else {
            Button(action: onImport) {
                Image(.importIco)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(.white)
                    .padding(8)
                    .overlay(
                        Circle()
                            .strokeBorder(Color.white.opacity(0.1), lineWidth: 1)
                    )
            }
        }
    }
}

// MARK: - Preview

#Preview {
    struct PreviewWrapper: View {
        @FocusState private var isFocused: Bool
        var body: some View {
            ChatInputBar(
                text: .constant(""),
                isInputFocused: $isFocused,
                hasText: false,
                onImport: {},
                onSend: {}
            )
        }
    }
    return PreviewWrapper()
}

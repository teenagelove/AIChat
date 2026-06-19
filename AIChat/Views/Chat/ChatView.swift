//
//  ChatView.swift
//  AIChat
//
//  Created by Danil Kazakov on 19.06.2026.
//

import SwiftUI

// MARK: - ChatView

struct ChatView: View {

    // MARK: - Dependencies

    @EnvironmentObject private var coordinator: Coordinator
    @StateObject private var viewModel = ChatViewModel()
    @FocusState private var isInputFocused: Bool

    // MARK: - Body

    var body: some View {
        ZStack {
            Color.backgroundClr
                .ignoresSafeArea(edges: .bottom)

            VStack(spacing: 0) {
                Spacer()

                centerContent

                Spacer()
            }

            VStack {
                Spacer()

                ChatInputBar(
                    text: $viewModel.messageText,
                    isInputFocused: $isInputFocused,
                    hasText: viewModel.hasText,
                    onImport: { viewModel.pasteFromClipboard() },
                    onSend: { viewModel.sendMessage() }
                )
                .padding(.horizontal, 16)
                .padding(.bottom, 8)
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButtonView {
                    coordinator.goBack()
                }
            }

            ToolbarItem(placement: .topBarLeading) {
                HStack(spacing: 12) {
                    Image(.generateBIco)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding(4)
                        .background(LinearGradient.primaryGradient)
                        .clipShape(Circle())

                    VStack(alignment: .leading, spacing: 2) {
                        Text(.chatTitle)
                            .font(.semiBold20)

                        Text(.chatDate)
                            .font(.regular14)
                            .foregroundColor(.white.opacity(0.3))
                    }
                }
            }

            ToolbarItem(placement: .topBarTrailing) {
                ForwardButtonView {}
            }
        }
        .task {
            try? await Task.sleep(for: .milliseconds(300))
            isInputFocused = true
        }
    }
}

private extension ChatView {

    // MARK: - UI Components

    var centerContent: some View {
        VStack(spacing: 16) {
            centerTitle

            Text(.chatCenterSubtitle)
                .font(.regular14)
                .foregroundColor(.white.opacity(0.5))
                .multilineTextAlignment(.center)
        }
        .padding(.bottom, 100)
    }

    var centerTitle: some View {
        HStack(spacing: 0) {
            Text("Your ")
            Text(.chatAiAssistant)
                .foregroundStyle(LinearGradient.primaryGradient)
            Text(" for anything")
        }
        .font(.semiBold20)
    }
}

// MARK: - Preview

#Preview {
    ChatView()
        .environmentObject(Coordinator())
}

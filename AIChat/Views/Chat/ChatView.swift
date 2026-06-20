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
    @StateObject private var viewModel: ChatViewModel
    @FocusState private var isInputFocused: Bool

    // MARK: - Init

    init(chatService: any ChatServiceProtocol) {
        _viewModel = StateObject(wrappedValue: ChatViewModel(chatService: chatService))
    }

    // MARK: - Body

    var body: some View {
        ZStack {
            Color.backgroundClr
                .ignoresSafeArea(edges: .bottom)

            VStack(spacing: 0) {
                if viewModel.messages.isEmpty {
                    ChatEmptyStateView()
                        .frame(maxHeight: .infinity)
                } else {
                    messageList
                }
            }
            .safeAreaInset(edge: .bottom) {
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

            toastOverlay
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
                            .foregroundStyle(.white.opacity(0.3))
                    }
                }
            }

            ToolbarItem(placement: .topBarTrailing) {
                ForwardButtonView {
                    coordinator.navigate(to: .chatList)
                }
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

    var toastOverlay: some View {
        Group {
            if let toast = viewModel.toast {
                VStack {
                    Spacer()
                    ToastView(message: toast.message, isSuccess: toast.isSuccess)
                        .padding(.bottom, 100)
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .animation(.easeInOut(duration: 0.3), value: viewModel.toast != nil)
            }
        }
    }

    var messageList: some View {
        ScrollViewReader { proxy in
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(viewModel.messages) { message in
                        ChatMessageBubble(
                            message: message,
                            onCopy: message.isUser ? nil : { viewModel.copyMessage(message) },
                            onRefresh: message.isUser ? nil : { viewModel.regenerateResponse() }
                        )
                        .id(message.id)
                    }

                    if viewModel.isLoading {
                        ChatMessageBubble(
                            message: ChatMessage(text: "", isUser: false, date: Date()),
                            isLoading: true
                        )
                        .id(Constants.IDs.loadingIndicator)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .padding(.bottom, 16)
            }
            .onChange(of: viewModel.messages.count) { _ in
                withAnimation {
                    proxy.scrollTo(viewModel.messages.last?.id, anchor: .bottom)
                }
            }
            .onChange(of: viewModel.isLoading) { isLoading in
                if isLoading {
                    withAnimation {
                        proxy.scrollTo(Constants.IDs.loadingIndicator, anchor: .bottom)
                    }
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    ChatView(chatService: ChatService())
        .environmentObject(Coordinator())
}

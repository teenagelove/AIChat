//
//  ChatListView.swift
//  AIChat
//
//  Created by Danil Kazakov on 20.06.2026.
//

import SwiftUI

// MARK: - ChatListView

struct ChatListView: View {

    // MARK: - Dependencies

    @EnvironmentObject private var coordinator: Coordinator
    @StateObject private var viewModel = ChatListViewModel(chatService: ChatService())

    // MARK: - Body

    var body: some View {
        ZStack {
            Color.backgroundClr
                .ignoresSafeArea(edges: .bottom)

            if viewModel.chats.isEmpty {
                ChatListEmptyView()
            } else {
                chatList
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
                Text(.chatListTitle)
                    .font(.semiBold20)
            }
        }
        .task {
            await viewModel.loadChats()
        }
    }
}

private extension ChatListView {

    // MARK: - UI Components

    var chatList: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(viewModel.chats) { chat in
                    chatRow(chat)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
        }
    }

    func chatRow(_ chat: DolaChat) -> some View {
        Button {
            coordinator.navigate(to: .chat)
        } label: {
            VStack(alignment: .leading, spacing: 4) {
                Text(chat.title ?? String(localized: "chat-list-untitled"))
                    .font(.semiBold16)
                    .foregroundStyle(.white)

                if let preview = chat.lastMessagePreview {
                    Text(preview)
                        .font(.regular14)
                        .foregroundStyle(.white.opacity(0.5))
                        .lineLimit(1)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(16)
            .background(Color.card.opacity(0.5))
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }
}

// MARK: - Preview

#Preview {
    ChatListView()
        .environmentObject(Coordinator())
}

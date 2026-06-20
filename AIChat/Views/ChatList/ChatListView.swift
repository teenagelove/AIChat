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
            LazyVStack(alignment: .leading, spacing: 16) {
                ForEach(viewModel.groupedChats, id: \.key) { section in
                    VStack(alignment: .leading, spacing: 12) {
                        Text(section.key)
                            .font(.semiBold20)
                            .padding(.horizontal, 16)

                        ForEach(section.value) { chat in
                            ChatHistoryRowView(
                                title: chat.title ?? String(
                                    localized: .chatListUntitled
                                ),
                                time: chat.date?.formatted(date: .omitted, time: .shortened) ?? ""
                            )
                            .padding(.horizontal, 16)
                        }
                    }
                }
            }
            .padding(.top, 16)
        }
    }
}

// MARK: - Preview

#Preview {
    ChatListView()
        .environmentObject(Coordinator())
}

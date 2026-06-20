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
    @StateObject private var viewModel: ChatListViewModel

    // MARK: - Init

    init(chatService: any ChatServiceProtocol) {
        _viewModel = StateObject(wrappedValue: ChatListViewModel(chatService: chatService))
    }

    // MARK: - Body

    var body: some View {
        ZStack {
            Color.backgroundClr
                .ignoresSafeArea(edges: .bottom)

            content
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
        .task { await viewModel.loadChats() }
    }
}

private extension ChatListView {

    // MARK: - Content

    @ViewBuilder
    var content: some View {
        switch viewModel.state {
        case .idle, .loading:
            ProgressView()
        case .loaded:
            chatList
        case .empty:
            ChatListEmptyView()
        case .error(let message):
            ErrorView(message: message) {
                Task { await viewModel.loadChats() }
            }
        }
    }

    // MARK: - Chat List

    var chatList: some View {
        List(viewModel.groupedChats) { section in
            Section(section.key) {
                ForEach(section.value) { chat in
                    ChatHistoryRowView(
                        title: chat.title ?? String(localized: .chatListUntitled),
                        time: chat.date?.formatted(date: .omitted, time: .shortened) ?? ""
                    )
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                }
            }
            .headerProminence(.increased)
        }
        .listStyle(.plain)
    }
}

// MARK: - Preview

#Preview {
    ChatListView(chatService: ChatService())
        .environmentObject(Coordinator())
}

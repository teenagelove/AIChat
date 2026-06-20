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
        .task {
            await viewModel.loadChats()
        }
    }
}

private extension ChatListView {

    // MARK: - Content

    @ViewBuilder
    var content: some View {
        switch viewModel.state {
        case .idle, .loading:
            ProgressView()
                .tint(.white)
        case .loaded:
            chatList
        case .empty:
            ChatListEmptyView()
        case .error(let message):
            VStack(spacing: 16) {
                Text(message)
                    .font(.regular14)
                    .foregroundStyle(.white.opacity(0.5))
                    .multilineTextAlignment(.center)

                Button {
                    Task { await viewModel.loadChats() }
                } label: {
                    Text(.chatListRetry)
                        .font(.semiBold16)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .background(LinearGradient.primaryGradient)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
            .padding(.horizontal, 32)
        }
    }

    // MARK: - Chat List

    var chatList: some View {
        List(viewModel.groupedChats, id: \.key) { section in
            Section(section.key) {
                ForEach(section.value) { chat in
                    ChatHistoryRowView(
                        title: chat.title ?? String(
                            localized: .chatListUntitled
                        ),
                        time: chat.date?.formatted(date: .omitted, time: .shortened) ?? ""
                    )
                    .listRowBackground(Color.card.opacity(0.5))
                    .listRowSeparator(.hidden)
                }
            }
            .headerProminence(.increased)
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
    }
}

// MARK: - Preview

#Preview {
    ChatListView()
        .environmentObject(Coordinator())
}

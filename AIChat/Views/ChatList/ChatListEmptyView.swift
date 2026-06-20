//
//  ChatListEmptyView.swift
//  AIChat
//
//  Created by Danil Kazakov on 20.06.2026.
//

import SwiftUI

// MARK: - ChatListEmptyView

struct ChatListEmptyView: View {

    // MARK: - Body

    var body: some View {
        VStack(spacing: 16) {
            Image(.magicPencilAIco)
                .resizable()
                .frame(width: 64, height: 64)

            Text(.chatListEmptyTitle)
                .font(.semiBold20)

            Text(.chatListEmptySubtitle)
                .font(.regular14)
                .foregroundStyle(.white.opacity(0.5))
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal, 32)
    }
}

// MARK: - Preview

#Preview {
    ChatListEmptyView()
        .background(Color.backgroundClr)
}

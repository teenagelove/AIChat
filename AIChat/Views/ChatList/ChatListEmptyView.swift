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
                .foregroundStyle(LinearGradient.primaryGradient)
                .frame(width: 60, height: 60)

            Text(.chatListEmptyTitle)
                .font(.bold28)

            Text(.chatListEmptySubtitle)
                .font(.regular16)
                .foregroundStyle(.white.opacity(0.5))
                .multilineTextAlignment(.center)
        }
    }
}

// MARK: - Preview

#Preview {
    ChatListEmptyView()
        .background(Color.backgroundClr)
}

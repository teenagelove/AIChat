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
            Image(.generateBIco)
                .resizable()
                .frame(width: 48, height: 48)
                .padding(8)
                .background(LinearGradient.primaryGradient)
                .clipShape(Circle())

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

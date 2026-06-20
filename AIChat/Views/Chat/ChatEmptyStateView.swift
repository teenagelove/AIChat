//
//  ChatEmptyStateView.swift
//  AIChat
//
//  Created by Danil Kazakov on 20.06.2026.
//

import SwiftUI

// MARK: - ChatEmptyStateView

struct ChatEmptyStateView: View {

    // MARK: - Body

    var body: some View {
        VStack(spacing: 16) {
            title

            Text(.chatCenterSubtitle)
                .font(.regular14)
                .foregroundColor(.white.opacity(0.5))
                .multilineTextAlignment(.center)
        }
    }
}

private extension ChatEmptyStateView {

    // MARK: - UI Components

    var title: some View {
        HStack(spacing: 0) {
            Text(.chatYour)
            Text(.chatAiAssistant)
                .foregroundStyle(LinearGradient.primaryGradient)
            Text(.chatForAnything)
        }
        .font(.semiBold20)
    }
}

// MARK: - Preview

#Preview {
    ChatEmptyStateView()
        .background(Color.backgroundClr)
}

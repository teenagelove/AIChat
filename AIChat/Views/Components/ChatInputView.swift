//
//  ChatInputView.swift
//  AIChat
//
//  Created by Danil Kazakov on 19.06.2026.
//

import SwiftUI

struct ChatInputView: View {
    let action: (() -> Void)?

    var body: some View {
        Button {
            action?()
        } label: {
            HStack(spacing: 16) {
                Image(.generateBIco)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)

                Text(.askAnythingPlaceholder)
                    .font(.regular16)
                    .foregroundStyle(.white.opacity(0.5))
            }
            .padding(16)
            .frame(maxWidth: .infinity, minHeight: 56, alignment: .leading)
            .background(Color.card.opacity(0.7))
            .clipShape(RoundedRectangle(cornerRadius: 24))
            .overlay(
                RoundedRectangle(cornerRadius: 24)
                    .strokeBorder(LinearGradient.primaryGradient.opacity(0.3), lineWidth: 2)
            )
        }
    }
}

#Preview {
    ZStack {
        Color.background
        ChatInputView(action: nil)
    }
}

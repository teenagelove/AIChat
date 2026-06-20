//
//  ChatHistoryRowView.swift
//  AIChat
//
//  Created by Danil Kazakov on 20.06.2026.
//

import SwiftUI

// MARK: - ChatHistoryRowView

struct ChatHistoryRowView: View {

    // MARK: - Properties

    let title: String
    let time: String

    // MARK: - Body

    var body: some View {
        HStack(spacing: 12) {
            Image(.generateBIco)
                .resizable()
                .foregroundStyle(LinearGradient.primaryGradient)
                .frame(width: 28, height: 28)

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.semiBold16)
                    .lineLimit(1)

                Text(time)
                    .font(.regular14)
                    .foregroundStyle(.white.opacity(0.5))
            }

            Spacer()
        }
        .padding(16)
        .background(Color.card.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

// MARK: - Preview

#Preview {
    ChatHistoryRowView(title: "Hello, this is a test recording....", time: "5:32 AM")
        .padding(.horizontal, 16)
}

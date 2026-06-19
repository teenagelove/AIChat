//
//  ErrorView.swift
//  AIChat
//
//  Created by Danil Kazakov on 19.06.2026.
//

import SwiftUI

// MARK: - ErrorView

struct ErrorView: View {

    // MARK: - Properties

    let message: String
    let action: () -> Void

    // MARK: - Body

    var body: some View {
        VStack(spacing: 12) {
            ErrorLottieView()
            errorMessage
            actionButton
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

private extension ErrorView {

    // MARK: - UI Components

    var errorMessage: some View {
        Text(message)
            .font(.regular16)
            .multilineTextAlignment(.center)
            .foregroundStyle(.secondary)
            .padding(.horizontal, 16)
    }

    var actionButton: some View {
        Button(action: action) {
            Label(.errorButtonTitle, systemImage: SFSymbol.arrowClockwise)
                .font(.semiBold16)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.blue.opacity(0.1))
                )
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Preview

#Preview {
    ErrorView(message: "Something went wrong") { }
}

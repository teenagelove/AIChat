//
//  ToastView.swift
//  AIChat
//
//  Created by Danil Kazakov on 20.06.2026.
//

import SwiftUI

// MARK: - ToastView

struct ToastView: View {

    // MARK: - Properties

    let message: String
    let isSuccess: Bool

    // MARK: - Body

    var body: some View {
        VStack(spacing: 8) {
            if isSuccess {
                Image(.checkIco)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundStyle(LinearGradient.primaryGradient)
                    .padding(8)
            } else {
                Image(.closeIco)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundStyle(.red)
                    .padding(8)
            }

            Text(message)
                .font(.regular16)
                .multilineTextAlignment(.center)
        }
        .padding(24)
        .frame(width: 240)
        .background(Color.card)
        .clipShape(
            UnevenRoundedRectangle(
                topLeadingRadius: 24,
                bottomLeadingRadius: 24,
                bottomTrailingRadius: 24,
                topTrailingRadius: 24
            )
        )
    }
}

// MARK: - Preview

#Preview {
    VStack(spacing: 16) {
        ToastView(message: "The text has been copied successfully", isSuccess: true)
        ToastView(message: "Something went wrong", isSuccess: false)
    }
    .background(Color.backgroundClr)
}

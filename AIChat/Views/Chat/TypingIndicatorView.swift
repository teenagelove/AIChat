//
//  TypingIndicatorView.swift
//  AIChat
//
//  Created by Danil Kazakov on 19.06.2026.
//

import SwiftUI

// MARK: - TypingIndicatorView

struct TypingIndicatorView: View {

    // MARK: - State

    @State private var activeDot = 0
    @State private var timer: Timer?

    // MARK: - Body

    var body: some View {
        HStack(spacing: 4) {
            dot(index: 0, size: 19)
            dot(index: 1, size: 15)
            dot(index: 2, size: 10)
        }
        .padding(16)
        .background(Color.card.opacity(0.5))
        .clipShape(
            UnevenRoundedRectangle(
                topLeadingRadius: 24,
                bottomLeadingRadius: 0,
                bottomTrailingRadius: 24,
                topTrailingRadius: 24
            )
        )
        .onAppear {
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
                withAnimation(.easeInOut(duration: 0.3)) {
                    activeDot = (activeDot + 1) % 3
                }
            }
        }
        .onDisappear {
            timer?.invalidate()
            timer = nil
        }
    }
}

private extension TypingIndicatorView {
    
    // MARK: - UI Components

    func dot(index: Int, size: CGFloat) -> some View {
        Circle()
            .fill(activeDot == index ? LinearGradient.primaryGradient : LinearGradient(colors: [.white.opacity(0.1)], startPoint: .leading, endPoint: .trailing))
            .frame(width: size, height: size)
    }
}

// MARK: - Preview

#Preview {
    TypingIndicatorView()
        .padding()
        .background(Color.backgroundClr)
}

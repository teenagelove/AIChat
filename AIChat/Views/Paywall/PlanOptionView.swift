//
//  PlanOptionView.swift
//  AIChat
//
//  Created by Danil Kazakov on 19.06.2026.
//

import SwiftUI

// MARK: - PlanOptionView

struct PlanOptionView: View {

    // MARK: - Properties

    let title: String
    let price: String
    let badge: String?
    let isSelected: Bool

    // MARK: - Body

    var body: some View {
        HStack {
            titleSection

            Spacer()

            if let badge {
                badgeView(badge)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 16)
        .contentShape(Rectangle())
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .strokeBorder(
                    isSelected ? LinearGradient.primaryGradient : LinearGradient(
                        colors: [.white.opacity(0.3), .white.opacity(0.3)],
                        startPoint: .leading,
                        endPoint: .trailing
                    ),
                    lineWidth: 1
                )
        )
    }
}

private extension PlanOptionView {

    // MARK: - UI Components

    var titleSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 2) {
                Text(title)
                    .font(.medium16)

                Text(.paywallPerWeek)
                    .font(.regular16)
            }

            Text(price)
                .font(.regular14)
                .foregroundStyle(.grayText)
        }
    }

    func badgeView(_ text: String) -> some View {
        Text(text)
            .font(.medium14)
            .foregroundStyle(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 6)
            .background(LinearGradient.primaryGradient)
            .clipShape(Capsule())
    }
}

// MARK: - Preview

#Preview("Selected") {
    VStack(spacing: 8) {
        PlanOptionView(
            title: "Annual",
            price: "$9.99",
            badge: "Save 67%",
            isSelected: true
        )

        PlanOptionView(
            title: "Monthly",
            price: "$29.99",
            badge: nil,
            isSelected: false
        )
    }
    .padding()
    .background(Color.black)
}

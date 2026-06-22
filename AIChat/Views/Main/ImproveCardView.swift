//
//  ImproveCardView.swift
//  AIChat
//
//  Created by Danil Kazakov on 20.06.2026.
//

import SwiftUI

// MARK: - ImproveCardView

struct ImproveCardView: View {

    // MARK: - Properties

    private let action: (() -> Void)?

    // MARK: - Init

    init(action: (() -> Void)? = nil) {
        self.action = action
    }

    // MARK: - Body

    var body: some View {
        FeatureCardView(
            icon: .magicPencilAIco,
            titleKey: String(localized: .improveText),
            tagKeys: [
                String(localized: .rewrite),
                String(localized: .fixGrammar)
            ],
            action: action
        )
    }
}

// MARK: - Preview

#Preview {
    ImproveCardView()
}

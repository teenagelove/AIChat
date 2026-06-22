//
//  SummarizeCardView.swift
//  AIChat
//
//  Created by Danil Kazakov on 20.06.2026.
//

import SwiftUI

// MARK: - SummarizeCardView

struct SummarizeCardView: View {

    // MARK: - Properties

    private let action: (() -> Void)?

    // MARK: - Init

    init(action: (() -> Void)? = nil) {
        self.action = action
    }

    // MARK: - Body

    var body: some View {
        FeatureCardView(
            icon: .promptAIco,
            titleKey: String(localized: .summarizeText),
            tagKeys: [
                String(localized: .summarize),
                String(localized: .keyPoints)
            ],
            action: action
        )
    }
}

// MARK: - Preview

#Preview {
    SummarizeCardView()
}

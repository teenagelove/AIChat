//
//  SummarizeCardView.swift
//  AIChat
//
//  Created by Danil Kazakov on 20.06.2026.
//

import SwiftUI

struct SummarizeCardView: View {
    private let action: (() -> Void)?

    init(action: (() -> Void)? = nil) {
        self.action = action
    }

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

#Preview {
    SummarizeCardView()
}

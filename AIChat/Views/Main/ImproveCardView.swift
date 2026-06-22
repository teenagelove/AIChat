//
//  ImproveCardView.swift
//  AIChat
//
//  Created by Danil Kazakov on 20.06.2026.
//

import SwiftUI

struct ImproveCardView: View {
    private let action: (() -> Void)?

    init(action: (() -> Void)? = nil) {
        self.action = action
    }

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

#Preview {
    ImproveCardView()
}

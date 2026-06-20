//
//  SummarizeCardView.swift
//  AIChat
//
//  Created by Danil Kazakov on 20.06.2026.
//

import SwiftUI

struct SummarizeCardView: View {
    var body: some View {
        FeatureCardView(
            icon: .magicPencilAIco,
            titleKey: "improve-text",
            tagKeys: ["rewrite", "fix-grammar"]
        )
    }
}

#Preview {
    SummarizeCardView()
}

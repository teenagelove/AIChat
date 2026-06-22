//
//  FeatureCardView.swift
//  AIChat
//
//  Created by Danil Kazakov on 20.06.2026.
//

import SwiftUI

struct FeatureCardView: View {
    let icon: ImageResource
    let titleKey: String
    let tagKeys: [String]
    private let action: (() -> Void)?

    init(icon: ImageResource, titleKey: String, tagKeys: [String], action: (() -> Void)? = nil) {
        self.icon = icon
        self.titleKey = titleKey
        self.tagKeys = tagKeys
        self.action = action
    }

    var body: some View {
        Button { action?() } label: {
            VStack(alignment: .leading, spacing: 0) {
                iconView
                    .padding(.bottom, 23)

                Text(LocalizedStringKey(titleKey))
                    .padding(.bottom, 8)

                tagsView
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.card)
            .clipShape(.rect(cornerRadius: 24))
        }
        .buttonStyle(.plain)
    }
}

private extension FeatureCardView {

    // MARK: - UI Components

    var iconView: some View {
        Image(icon)
            .resizable()
            .scaledToFit()
            .foregroundStyle(LinearGradient.primaryGradient)
            .frame(width: 20, height: 20)
            .frame(width: 36, height: 36)
            .background(.accent.opacity(0.05), in: .circle)
    }

    var tagsView: some View {
        HStack(spacing: 6) {
            ForEach(Array(tagKeys.enumerated()), id: \.offset) { index, key in
                if index > 0 {
                    Capsule()
                        .frame(width: 4, height: 4)
                }

                Text(LocalizedStringKey(key))
                    .font(.medium12)
            }
        }
        .opacity(0.7)
    }
}

#Preview {
    ImproveCardView()
}

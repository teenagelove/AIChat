//
//  GeneratingView.swift
//  AIChat
//
//  Created by Danil Kazakov on 22.06.2026.
//

import SwiftUI

// MARK: - GeneratingView

struct GeneratingView: View {

    // MARK: - Body

    var body: some View {
        VStack(spacing: 40) {
            Image(.imageLoading)

            VStack(spacing: 8) {
                Text(String(localized: .generatingTitle))
                    .font(.semiBold20)

                Text(String(localized: .generatingSubtitle))
                    .font(.regular16)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - Preview

#Preview {
    GeneratingView()
        .background(Color.backgroundClr)
}

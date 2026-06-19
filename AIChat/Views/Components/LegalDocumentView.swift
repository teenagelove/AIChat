//
//  LegalDocumentView.swift
//  AIChat
//
//  Created by Danil Kazakov on 19.06.2026.
//

import SwiftUI

// MARK: - LegalDocumentView

struct LegalDocumentView: View {

    // MARK: - Dependencies

    @Environment(\.dismiss) private var dismiss

    // MARK: - Properties

    let content: String

    // MARK: - Body

    var body: some View {
        NavigationStack {
            ScrollView {
                Text(content)
                    .font(.regular14)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 16)
                    .padding(.top, 24)
            }
            .background(BackgroundView())
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(.legalDone) {
                        dismiss()
                    }
                    .foregroundStyle(.white)
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    LegalDocumentView(content: String(localized: .legalPrivacyPolicyText))
}

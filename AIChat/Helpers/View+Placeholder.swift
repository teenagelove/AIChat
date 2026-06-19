//
//  View+Placeholder.swift
//  AIChat
//
//  Created by Danil Kazakov on 19.06.2026.
//

import SwiftUI

// MARK: - View Extension

extension View {

    // MARK: - Placeholder

    func placeholder<Content: View>(
        _ placeholder: Content,
        when shouldShow: Bool,
        alignment: Alignment = .leading
    ) -> some View {
        overlay(alignment: alignment) {
            if shouldShow {
                placeholder
                    .allowsHitTesting(false)
            }
        }
    }
}

//
//  CustomProgressView.swift
//  AIChat
//
//  Created by Danil Kazakov on 21.06.2026.
//

import SwiftUI

// MARK: - CustomProgressView

struct CustomProgressView: View {

    // MARK: - Body

    var body: some View {
        ProgressView()
            .tint(LinearGradient.primaryGradient)
    }
}

// MARK: - Preview

#Preview {
    CustomProgressView()
}

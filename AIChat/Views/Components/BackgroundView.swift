//
//  BackgroundView.swift
//  AIChat
//
//  Created by Danil Kazakov on 18.06.2026.
//

import SwiftUI

// MARK: - BackgroundView

struct BackgroundView: View {

    // MARK: - Body

    var body: some View {
        Image(.gradientBackground)
            .resizable()
            .blur(radius: 50)
            .ignoresSafeArea()
    }
}

// MARK: - Preview

#Preview {
    BackgroundView()
}

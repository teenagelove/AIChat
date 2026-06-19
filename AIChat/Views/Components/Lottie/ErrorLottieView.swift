//
//  ErrorLottieView.swift
//  AIChat
//
//  Created by Danil Kazakov on 19.06.2026.
//

import Lottie
import SwiftUI

// MARK: - ErrorLottieView

struct ErrorLottieView: View {

    // MARK: - Body

    var body: some View {
        LottieView(animation: .named("error"))
            .playing(loopMode: .loop)
            .resizable()
            .frame(width: 100, height: 100)
    }
}

// MARK: - Preview

#Preview {
    ErrorLottieView()
}

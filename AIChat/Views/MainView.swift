//
//  MainView.swift
//  AIChat
//
//  Created by Danil Kazakov on 18.06.2026.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        ZStack(alignment: .top) {
            Color.background
                .ignoresSafeArea()

            topGlow

            content
        }
        .overlay(alignment: .topTrailing) {
            settingsButton
        }
    }
}

private extension MainView {
    var settingsButton: some View {
        SettingsButtonView()
            .padding(.top, 16)
            .padding(.trailing, 16)
    }

    var content: some View {
        VStack(spacing: 24) {
            header

            ChatInputView(action: nil)

            Spacer()
        }
        .padding(.top, 46)
    }

    var topGlow: some View {
        LinearGradient.primaryGradient
            .blur(radius: 50)
            .opacity(0.3)
            .frame(maxWidth: .infinity, maxHeight: 100)
    }

    var header: some View {
        VStack(spacing: 24) {
            Image(.generateB1Ico)
                .resizable()
                .frame(width: 60, height: 60)
                .foregroundStyle(LinearGradient.primaryGradient)

            Text(.welcomeMainText)
                .font(.bold28)
                .lineLimit(2)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    MainView()
}

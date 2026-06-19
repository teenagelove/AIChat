//
//  MainView.swift
//  AIChat
//
//  Created by Danil Kazakov on 18.06.2026.
//

import SwiftUI

// MARK: - MainView

struct MainView: View {

    // MARK: - Body

    var body: some View {
        ZStack(alignment: .top) {
            BackgroundView()

            content
        }
        .overlay(alignment: .topTrailing) {
            settingsButton
        }
    }
}

private extension MainView {

    // MARK: - UI Components

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

// MARK: - Preview

#Preview {
    MainView()
}

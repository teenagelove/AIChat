//
//  MainView.swift
//  AIChat
//
//  Created by Danil Kazakov on 18.06.2026.
//

import SwiftUI

// MARK: - MainView

struct MainView: View {

    // MARK: - Dependencies

    @EnvironmentObject private var coordinator: Coordinator

    @State private var isShowingNotImplemented = false

    // MARK: - Body

    var body: some View {
        ZStack {
            BackgroundView()

            content
        }
        .overlay(alignment: .topTrailing) {
            settingsButton
        }
        .alert(.notImplementedTitle, isPresented: $isShowingNotImplemented) {
            Button(.ok, role: .cancel) {}
        } message: {
            Text(.notImplementedMessage)
        }
    }
}

private extension MainView {

    // MARK: - UI Components

    var settingsButton: some View {
        SettingsButtonView {
            isShowingNotImplemented = true
        }
        .padding(.top, 16)
        .padding(.trailing, 16)
    }

    var content: some View {
        VStack(spacing: 40) {
            VStack(spacing: 24) {
                header

                ChatInputView {
                    coordinator.navigate(to: .chat)
                }
            }

            HStack(alignment: .top, spacing: 8) {
                VideoGenCardView {
                    coordinator.navigate(to: .videoTemplates)
                }

                VStack(spacing: 8) {
                    ImproveCardView()
                        .onTapGesture { isShowingNotImplemented = true }

                    SummarizeCardView()
                        .onTapGesture { isShowingNotImplemented = true }
                }
            }
        }
        .padding(.horizontal, 16)
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
        .environmentObject(Coordinator())
}

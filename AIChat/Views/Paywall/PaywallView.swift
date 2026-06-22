//
//  PaywallView.swift
//  AIChat
//
//  Created by Danil Kazakov on 19.06.2026.
//

import SwiftUI

// MARK: - PaywallView

struct PaywallView: View {

    // MARK: - Dependencies

    @EnvironmentObject private var coordinator: Coordinator
    @EnvironmentObject private var viewModel: PaywallViewModel

    // MARK: - Body

    var body: some View {
        ZStack {
            BackgroundView()

            VStack(spacing: 24) {
                Spacer()

                content

                PaywallBottomBarView()
            }
            .padding(.bottom, 8)
        }
        .navigationBarHidden(true)
        .overlay(alignment: .topLeading) {
            CloseButtonView { viewModel.showCloseAlert = true }
                .padding(.top, 16)
                .padding(.leading, 16)
                .opacity(viewModel.showCloseButton ? 1 : 0)
                .animation(.easeIn(duration: 1.0), value: viewModel.showCloseButton)
        }
        .alert(.paywallCloseTitle, isPresented: $viewModel.showCloseAlert) {
            Button(.paywallCloseOk) {
                exit(0)
            }
            Button(.paywallCloseCancel, role: .cancel) {}
        } message: {
            Text(.paywallCloseMessage)
        }
        .alert(String(localized: .restorePurchases), isPresented: $viewModel.showRestoreAlert) {
            Button(.paywallCloseOk) {}
        } message: {
            Text(viewModel.restoreAlertMessage)
        }
        .task { await viewModel.loadProducts() }
        .onChange(of: viewModel.hasPremiumAccess) { hasAccess in
            if hasAccess {
                coordinator.popToRoot()
            }
        }
    }
}

private extension PaywallView {

    // MARK: - UI Components

    @ViewBuilder
    var content: some View {
        switch viewModel.state {
        case .idle, .loading:
            ProgressView()
                .frame(maxWidth: .infinity)
        case .loaded:
            loadedContent
        case .error(let message):
            ErrorView(message: message) {
                Task { await viewModel.loadProducts() }
            }
        }
    }

    var loadedContent: some View {
        VStack(spacing: 32) {
            titleSection

            benefitsList

            PurchaseOptionsView()
        }
    }

    var titleSection: some View {
        Text(.paywallTitle)
            .font(.bold34)
            .multilineTextAlignment(.center)
    }

    var benefitsList: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(Benefit.mock) { benefit in
                benefitRow(icon: benefit.icon, title: benefit.title)
            }
        }
    }

    func benefitRow(icon: ImageResource, title: String) -> some View {
        HStack(spacing: 8) {
            Image(icon)
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundStyle(LinearGradient.primaryGradient)

            Text(title)
                .font(.medium16)
        }
    }
}

// MARK: - Preview

#Preview {
    let service = SubscriptionService()
    let viewModel = PaywallViewModel(subscriptionService: service)
    return PaywallView()
        .environmentObject(Coordinator())
        .environmentObject(viewModel)
}

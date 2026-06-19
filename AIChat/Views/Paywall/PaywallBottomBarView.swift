//
//  PaywallBottomBarView.swift
//  AIChat
//
//  Created by Danil Kazakov on 19.06.2026.
//

import SwiftUI

// MARK: - PaywallBottomBarView

struct PaywallBottomBarView: View {

    // MARK: - Dependencies

    @EnvironmentObject private var viewModel: PaywallViewModel

    // MARK: - Properties

    @State private var showTermsOfUse = false
    @State private var showPrivacyPolicy = false

    // MARK: - Body

    var body: some View {
        VStack(spacing: 18) {
            cancelAnytimeRow

            unlockButton

            legalLinks
        }
        .sheet(isPresented: $showTermsOfUse) {
            LegalDocumentView(content: String(localized: .legalTermsOfUseText))
        }
        .sheet(isPresented: $showPrivacyPolicy) {
            LegalDocumentView(content: String(localized: .legalPrivacyPolicyText))
        }
    }
}

private extension PaywallBottomBarView {

    // MARK: - UI Components

    var cancelAnytimeRow: some View {
        HStack(spacing: 8) {
            Image(systemName: SFSymbol.clockArrowCirclePath)
                .font(.system(size: 12))
                .foregroundStyle(.grayText)

            Text(.paywallCancelAnytime)
                .font(.system(size: 12, weight: .regular))
                .foregroundStyle(.grayText)
        }
    }

    var unlockButton: some View {
        Button {
            Task { await viewModel.purchase() }
        } label: {
            if viewModel.isPurchasing {
                ProgressView()
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(LinearGradient.primaryGradient)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
            } else {
                Text(.paywallUnlockNow)
                    .font(.semiBold16)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(LinearGradient.primaryGradient)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
            }
        }
        .disabled(viewModel.isPurchasing)
        .padding(.horizontal, 16)
    }

    var legalLinks: some View {
        HStack {
            Button(.paywallPrivacyPolicy) {
                showPrivacyPolicy = true
            }
            .frame(maxWidth: .infinity)

            Button(.paywallRestorePurchases) {
                Task { await viewModel.restorePurchases() }
            }
            .frame(maxWidth: .infinity)

            Button(.paywallTermsOfUse) {
                showTermsOfUse = true
            }
            .frame(maxWidth: .infinity)
        }
        .font(.system(size: 11))
        .foregroundStyle(.grayText)
    }
}

// MARK: - Preview

#Preview {
    let service = SubscriptionService()
    let viewModel = PaywallViewModel(subscriptionService: service)
    return PaywallBottomBarView()
        .environmentObject(viewModel)
        .background(Color.black)
}

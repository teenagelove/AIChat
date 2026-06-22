//
//  PurchaseOptionsView.swift
//  AIChat
//
//  Created by Danil Kazakov on 19.06.2026.
//

import SwiftUI
import StoreKit

// MARK: - PurchaseOptionsView

struct PurchaseOptionsView: View {

    // MARK: - Dependencies

    @EnvironmentObject private var viewModel: PaywallViewModel

    // MARK: - Body

    var body: some View {
        VStack(spacing: 8) {
            if let yearlyProduct = viewModel.products.first(where: {
                $0.id.contains("year") || $0.id.contains("yearly")
            }) {
                planRow(
                    product: yearlyProduct,
                    title: String(localized: .paywallYearPlan),
                    badge: String(localized: .paywallSaveBadge),
                    isSelected: viewModel.selectedPlan == .year
                ) {
                    viewModel.selectPlan(.year)
                }
            }

            if let weeklyProduct = viewModel.products.first(where: {
                $0.id.contains("week") || $0.id.contains("weekly")
            }) {
                planRow(
                    product: weeklyProduct,
                    title: String(localized: .paywallMonthPlan),
                    badge: nil,
                    isSelected: viewModel.selectedPlan == .month
                ) {
                    viewModel.selectPlan(.month)
                }
            }
        }
        .padding(.horizontal, 16)
        .animation(.easeInOut(duration: 0.2), value: viewModel.selectedPlan)
    }
}

private extension PurchaseOptionsView {

    // MARK: - UI Components

    func planRow(
        product: Product,
        title: String,
        badge: String?,
        isSelected: Bool,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            PlanOptionView(
                title: title,
                price: product.displayPrice,
                badge: badge,
                isSelected: isSelected
            )
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Preview

#Preview {
    let service = SubscriptionService()
    let viewModel = PaywallViewModel(subscriptionService: service)
    return PurchaseOptionsView()
        .environmentObject(viewModel)
        .background(Color.black)
}

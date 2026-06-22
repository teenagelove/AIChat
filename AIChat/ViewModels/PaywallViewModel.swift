//
//  PaywallViewModel.swift
//  AIChat
//
//  Created by Danil Kazakov on 19.06.2026.
//

import Combine
import StoreKit

// MARK: - PaywallViewModel

@MainActor
final class PaywallViewModel: ObservableObject {

    // MARK: - State

    enum State {
        case idle
        case loading
        case loaded([Product])
        case error(String)
    }

    // MARK: - Published

    @Published var state: State = .idle
    @Published var selectedPlan: Plan = .year
    @Published var showCloseButton = false
    @Published var showCloseAlert = false
    @Published var showRestoreAlert = false
    @Published var restoreAlertMessage = ""
    @Published var isPurchasing = false

    // MARK: - Dependencies

    private let subscriptionService: any SubscriptionServiceProtocol

    // MARK: - Computed

    var products: [Product] {
        if case let .loaded(products) = state {
            return products
        }
        return []
    }

    var hasPremiumAccess: Bool {
        subscriptionService.hasPremiumAccess
    }

    // MARK: - Init

    init(subscriptionService: any SubscriptionServiceProtocol) {
        self.subscriptionService = subscriptionService
    }

    // MARK: - Actions

    func loadProducts() async {
        state = .loading

        do {
            let loadedProducts = try await subscriptionService.loadProducts()
            state = .loaded(loadedProducts)
        } catch {
            state = .error(error.localizedDescription)
        }

        try? await Task.sleep(for: .seconds(2))
        showCloseButton = true
    }

    func purchase() async {
        guard let product = selectedProduct else { return }

        isPurchasing = true
        _ = await subscriptionService.purchase(product)
        isPurchasing = false
    }

    func restorePurchases() async {
        isPurchasing = true
        let success = await subscriptionService.restorePurchases()
        isPurchasing = false

        if success {
            subscriptionService.refreshSubscriptionStatus()
            restoreAlertMessage = String(localized: .restoreSuccess)
        } else {
            restoreAlertMessage = String(localized: .restoreFailure)
        }
        showRestoreAlert = true
    }

    func selectPlan(_ plan: Plan) {
        selectedPlan = plan
    }
}

private extension PaywallViewModel {

    // MARK: - Computed

    var selectedProduct: Product? {
        switch selectedPlan {
        case .year:
            return products.first(where: {
                $0.id.contains("year") || $0.id.contains("yearly")
            })
        case .month:
            return products.first(where: {
                $0.id.contains("week") || $0.id.contains("weekly")
            })
        }
    }
}

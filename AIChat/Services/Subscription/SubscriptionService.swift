//
//  SubscriptionService.swift
//  AIChat
//
//  Created by Danil Kazakov on 19.06.2026.
//

import Combine
import ApphudSDK
import StoreKit
import UIKit

// MARK: - SubscriptionService

final class SubscriptionService: SubscriptionServiceProtocol {

    // MARK: - Published

    @Published private(set) var hasPremiumAccess = false
    @Published private(set) var isSubscriptionChecked = false

    // MARK: - Lifecycle

    func start() {
        Apphud.start(apiKey: Constants.API.apphudApiKey)
        Apphud.setDeviceIdentifiers(
            idfa: nil,
            idfv: UIDevice.current.identifierForVendor?.uuidString
        )
        checkSubscriptionStatus()
    }

    func checkSubscriptionStatus() {
        hasPremiumAccess = Apphud.hasPremiumAccess()
        isSubscriptionChecked = true
    }

    // MARK: - Products

    func loadProducts() async throws -> [Product] {
        try await Apphud.fetchProducts()
    }

    // MARK: - Purchase

    func purchase(_ product: Product) async -> Bool {
        let result = await Apphud.purchase(product)
        let success = result.success || result.subscription?.isActive() == true
        if success {
            hasPremiumAccess = true
        }
        return success
    }

    // MARK: - Restore

    func restorePurchases() async -> Bool {
        do {
            try await AppStore.sync()
        } catch {
            return false
        }

        let isActive = Apphud.hasPremiumAccess()
        if isActive {
            hasPremiumAccess = true
        }
        return isActive
    }

    // MARK: - Status

    func refreshSubscriptionStatus() {
        hasPremiumAccess = Apphud.hasPremiumAccess()
    }
}

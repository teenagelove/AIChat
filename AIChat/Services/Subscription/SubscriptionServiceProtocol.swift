//
//  SubscriptionServiceProtocol.swift
//  AIChat
//
//  Created by Danil Kazakov on 20.06.2026.
//

import Combine
import StoreKit

// MARK: - SubscriptionServiceProtocol

protocol SubscriptionServiceProtocol: ObservableObject {
    var hasPremiumAccess: Bool { get }
    var isSubscriptionChecked: Bool { get }

    func start()
    func checkSubscriptionStatus()
    func loadProducts() async throws -> [Product]
    func purchase(_ product: Product) async -> Bool
    func restorePurchases() async -> Bool
    func refreshSubscriptionStatus()
}

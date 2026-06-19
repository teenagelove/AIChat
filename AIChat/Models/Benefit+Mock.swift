//
//  Benefit+Mock.swift
//  AIChat
//
//  Created by Danil Kazakov on 19.06.2026.
//

import SwiftUI

// MARK: - Benefit Mock

extension Benefit {
    static let mock: [Benefit] = [
        Benefit(
            icon: .generateBIco,
            title: String(localized: .paywallBenefit1)
        ),
        Benefit(
            icon: .magicPencilAIco,
            title: String(localized: .paywallBenefit2)
        ),
        Benefit(
            icon: .promptAIco,
            title: String(localized: .paywallBenefit3)
        ),
        Benefit(
            icon: .imageIco,
            title: String(localized: .paywallBenefit4)
        )
    ]
}

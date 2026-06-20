//
//  BackButtonView.swift
//  AIChat
//
//  Created by Danil Kazakov on 19.06.2026.
//

import SwiftUI

// MARK: - BackButtonView

struct BackButtonView: View {

    // MARK: - Properties

    let action: () -> Void

    // MARK: - Body

    var body: some View {
        Button(action: action) {
            Image(.arrowIco)
                .resizable()
                .frame(width: 24, height: 24)
        }
    }
}

// MARK: - Preview

#Preview {
    BackButtonView {}
}

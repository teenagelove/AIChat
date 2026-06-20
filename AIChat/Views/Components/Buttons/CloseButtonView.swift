//
//  CloseButtonView.swift
//  AIChat
//
//  Created by Danil Kazakov on 19.06.2026.
//

import SwiftUI

// MARK: - CloseButtonView

struct CloseButtonView: View {

    // MARK: - Properties

    let action: (() -> Void)

    // MARK: - Body

    var body: some View {
        Button {
            action()
        } label: {
            Image(.closeIco)
                .resizable()
                .frame(width: 24, height: 24)
        }
        .opacity(0.7)
    }
}

// MARK: - Preview

#Preview {
    CloseButtonView {}
}

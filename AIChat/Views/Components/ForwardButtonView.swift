//
//  ForwardButtonView.swift
//  AIChat
//
//  Created by Danil Kazakov on 19.06.2026.
//

import SwiftUI

// MARK: - ForwardButtonView

struct ForwardButtonView: View {

    // MARK: - Properties

    let action: () -> Void

    // MARK: - Body

    var body: some View {
        Button(action: action) {
            Image(.unionIco)
                .resizable()
                .frame(width: 24, height: 24)
        }
    }
}

// MARK: - Preview

#Preview {
    ForwardButtonView {}
}

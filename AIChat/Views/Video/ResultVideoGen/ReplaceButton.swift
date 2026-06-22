//
//  ReplaceButton.swift
//  AIChat
//
//  Created by Danil Kazakov on 22.06.2026.
//

import SwiftUI

// MARK: - ReplaceButton

struct ReplaceButton: View {

    // MARK: - Action

    let action: () -> Void

    // MARK: - Body

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(.refresh2Ico)
                    .frame(width: 24, height: 24)

                Text(.replaceButton)
                    .font(.regular14)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(.grayText.opacity(0.5))
            .clipShape(.rect(cornerRadius: 24))
        }
    }
}

// MARK: - Preview

#Preview {
    ReplaceButton(action: {})
}

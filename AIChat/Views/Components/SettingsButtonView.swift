//
//  SettingsButtonView.swift
//  AIChat
//
//  Created by Danil Kazakov on 19.06.2026.
//

import SwiftUI

struct SettingsButtonView: View {
    let action: (() -> Void)? = nil

    var body: some View {
        Button {
            action?()
        } label: {
            Image(.setting2Ico)
                .resizable()
                .scaledToFit()
                .frame(width: 28, height: 28)
        }
        .frame(width: 40, height: 40)
        .background(.buttonBlur)
        .opacity(0.4)
        .clipShape(.circle)
    }
}

#Preview {
    SettingsButtonView()
}

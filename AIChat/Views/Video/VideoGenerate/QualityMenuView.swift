//
//  QualityMenuView.swift
//  AIChat
//
//  Created by Danil Kazakov on 22.06.2026.
//

import SwiftUI

// MARK: - QualityMenuView

struct QualityMenuView: View {

    // MARK: - Properties

    @Binding var selectedQuality: VideoQuality
    @Binding var isPresented: Bool
    let availableQualities: [VideoQuality]

    // MARK: - Body

    var body: some View {
        VStack(spacing: 0) {
            let items = Array(availableQualities.enumerated())
            ForEach(items, id: \.element) { index, quality in
                if index > 0 {
                    Divider().background(Color.white.opacity(0.1))
                }
                qualityButton(quality)
            }
        }
        .frame(width: 175)
        .background(Color(.card))
        .clipShape(.rect(cornerRadius: 16))
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
        .padding(.trailing, 16)
        .padding(.bottom, 110)
    }
}

// MARK: - Private

private extension QualityMenuView {

    func qualityButton(_ quality: VideoQuality) -> some View {
        Button {
            selectedQuality = quality
            isPresented = false
        } label: {
            Group {
                if quality == selectedQuality {
                    Text(quality.rawValue)
                        .foregroundStyle(LinearGradient.primaryGradient)
                } else {
                    Text(quality.rawValue)
                        .foregroundStyle(.white)
                }
            }
            .font(.regular16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
        }
    }
}

// MARK: - Preview

#Preview {
    QualityMenuView(
        selectedQuality: .constant(.hd1080),
        isPresented: .constant(true),
        availableQualities: VideoQuality.allCases
    )
}

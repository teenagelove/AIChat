//
//  PhotoSlotsView.swift
//  AIChat
//
//  Created by Danil Kazakov on 22.06.2026.
//

import SwiftUI

// MARK: - PhotoSlotsView

struct PhotoSlotsView: View {

    // MARK: - Properties

    let supportedCount: Int
    let selectedImages: [Int: UIImage]
    let isLoadingIndex: Int?
    let onSlotTap: (Int) -> Void

    // MARK: - Body

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 12) {
                ForEach(0..<supportedCount, id: \.self) { index in
                    slotButton(index: index)
                }
            }
        }
    }

    // MARK: - Private

    private func slotButton(index: Int) -> some View {
        Button {
            onSlotTap(index)
        } label: {
            if isLoadingIndex == index {
                CustomProgressView()
                    .frame(width: 100, height: 100)
                    .background(Color(.card))
                    .clipShape(.rect(cornerRadius: 20))
            } else if let image = selectedImages[index] {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipShape(.rect(cornerRadius: 20))
            } else {
                Image(systemName: SFSymbol.plus)
                    .font(.system(size: 28, weight: .light))
                    .foregroundStyle(.white)
                    .frame(width: 100, height: 100)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(
                                LinearGradient.primaryGradient,
                                lineWidth: 1.5
                            )
                    )
            }
        }
        .disabled(isLoadingIndex != nil)
    }
}

// MARK: - Preview

#Preview {
    PhotoSlotsView(
        supportedCount: 2,
        selectedImages: [:],
        isLoadingIndex: nil,
        onSlotTap: { _ in }
    )
}

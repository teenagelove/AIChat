//
//  FormatMenuView.swift
//  AIChat
//
//  Created by Danil Kazakov on 22.06.2026.
//

import SwiftUI

// MARK: - FormatMenuView

struct FormatMenuView: View {

    // MARK: - Properties

    @Binding var selectedFormat: VideoFormat
    @Binding var isPresented: Bool

    // MARK: - Body

    var body: some View {
        VStack(spacing: 0) {
            ForEach(VideoFormat.allCases) { format in
                if format != VideoFormat.allCases.first {
                    Divider().background(Color.white.opacity(0.1))
                }
                Button {
                    selectedFormat = format
                    isPresented = false
                } label: {
                    HStack {
                        if format == selectedFormat {
                            Text(format.rawValue)
                                .font(.regular16)
                                .foregroundStyle(LinearGradient.primaryGradient)
                        } else {
                            Text(format.rawValue)
                                .font(.regular16)
                                .foregroundStyle(.white)
                        }
                        Spacer()
                        format.icon(isSelected: format == selectedFormat)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 14)
                }
            }
        }
        .frame(width: 175)
        .background(Color(.card))
        .clipShape(.rect(cornerRadius: 16))
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
        .padding(.trailing, 16)
        .padding(.bottom, 160)
    }
}

// MARK: - Preview

#Preview {
    FormatMenuView(
        selectedFormat: .constant(.horizontal),
        isPresented: .constant(true)
    )
}

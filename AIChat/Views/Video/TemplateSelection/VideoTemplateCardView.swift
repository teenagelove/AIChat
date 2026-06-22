//
//  VideoTemplateCardView.swift
//  AIChat
//
//  Created by Danil Kazakov on 20.06.2026.
//

import SwiftUI

// MARK: - VideoTemplateCardView

struct VideoTemplateCardView: View {

    // MARK: - Properties

    let title: String
    let previewURL: String
    private let action: (() -> Void)?

    // MARK: - Init

    init(title: String, previewURL: String, action: (() -> Void)? = nil) {
        self.title = title
        self.previewURL = previewURL
        self.action = action
    }

    // MARK: - Body

    var body: some View {
        Button { action?() } label: {
            ZStack(alignment: .bottom) {
                Image(.imageMock)
                    .resizable()
                    .aspectRatio(contentMode: .fill)

                LinearGradient(
                    colors: [
                        Color(.gradientGray),
                        Color(.gradientGray).opacity(0)
                    ],
                    startPoint: .bottom,
                    endPoint: .top
                )

                Text(title)
                    .font(.regular16)
                    .padding(.bottom, 8)
            }
            .clipShape(.rect(cornerRadius: 24))
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Preview

#Preview {
    VideoTemplateCardView(title: "Title", previewURL: "")
        .frame(height: 280)
}

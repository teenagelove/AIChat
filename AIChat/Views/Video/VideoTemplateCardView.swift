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
    let image: ImageResource
    private let action: (() -> Void)?

    // MARK: - Init

    init(title: String, image: ImageResource, action: (() -> Void)? = nil) {
        self.title = title
        self.image = image
        self.action = action
    }

    // MARK: - Body

    var body: some View {
        Button { action?() } label: {
            ZStack(alignment: .bottom) {
                Image(image)
                    .resizable()
                    .aspectRatio(171/232, contentMode: .fill)

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
    VideoTemplateCardView(title: "Title", image: .imageMock)
        .frame(height: 280)
}

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

    // MARK: - Body

    var body: some View {
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
}

// MARK: - Preview

#Preview {
    VideoTemplateCardView(title: "Title", image: .imageMock)
        .frame(height: 280)
}

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
                .aspectRatio(3/4, contentMode: .fit)

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

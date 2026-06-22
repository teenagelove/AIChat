//
//  TemplateThumbnailView.swift
//  AIChat
//
//  Created by Danil Kazakov on 22.06.2026.
//

import SwiftUI

// MARK: - TemplateThumbnailView

struct TemplateThumbnailView: View {

    // MARK: - Properties

    let previewURL: String

    // MARK: - Body

    var body: some View {
        Image(.imageMock)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .clipShape(.rect(cornerRadius: 16))
    }
}

// MARK: - Preview

#Preview {
    TemplateThumbnailView(previewURL: "")
        .frame(width: 300, height: 300)
}

//
//  TemplateThumbnailView.swift
//  AIChat
//
//  Created by Danil Kazakov on 22.06.2026.
//

import SwiftUI
import AVKit

// MARK: - TemplateThumbnailView

struct TemplateThumbnailView: View {

    // MARK: - Properties

    let player: AVPlayer?

    // MARK: - Body

    var body: some View {
        Group {
            if let player {
                VideoPlayer(player: player)
            } else {
                Image(.imageMock)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
        }
        .clipShape(.rect(cornerRadius: 16))
    }
}

// MARK: - Preview

#Preview {
    TemplateThumbnailView(player: nil)
        .frame(width: 300, height: 300)
}

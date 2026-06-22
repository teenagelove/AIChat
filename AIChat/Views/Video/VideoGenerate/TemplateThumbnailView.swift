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

    let previewURL: String

    // MARK: - State

    @State private var player: AVPlayer?

    // MARK: - Body

    var body: some View {
        Group {
            if let player {
                VideoPlayer(player: player)
                    .onAppear { player.play() }
                    .onDisappear { player.pause() }
            } else {
                Image(.imageMock)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
        }
        .clipShape(.rect(cornerRadius: 16))
        .onAppear {
            guard player == nil,
                  let url = URL(string: previewURL),
                  !previewURL.isEmpty
            else { return }

            player = AVPlayer(url: url)
        }
    }
}

// MARK: - Preview

#Preview {
    TemplateThumbnailView(previewURL: "")
        .frame(width: 300, height: 300)
}

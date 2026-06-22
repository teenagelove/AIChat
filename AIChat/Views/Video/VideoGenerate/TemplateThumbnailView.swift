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
    @State private var isLoading = false

    // MARK: - Body

    var body: some View {
        Group {
            if let player {
                VideoPlayer(player: player)
                    .onAppear { player.play() }
                    .onDisappear { player.pause() }
            } else if isLoading {
                CustomProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
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

            isLoading = true
            player = AVPlayer(url: url)
            isLoading = false
        }
    }
}

// MARK: - Preview

#Preview {
    TemplateThumbnailView(previewURL: "")
        .frame(width: 300, height: 300)
}

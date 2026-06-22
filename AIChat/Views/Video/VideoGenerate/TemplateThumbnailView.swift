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
        ZStack {
            if let player {
                VideoPlayer(player: player)
                    .clipShape(.rect(cornerRadius: 16))
            } else if isLoading {
                Color(.card)
                    .clipShape(.rect(cornerRadius: 16))
                    .overlay {
                        ProgressView()
                            .tint(.white)
                    }
            } else {
                Image(.imageMock)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(.rect(cornerRadius: 16))
            }
        }
        .task(id: previewURL) {
            await loadPlayer()
        }
    }
}

// MARK: - Private

private extension TemplateThumbnailView {

    func loadPlayer() async {
        guard !previewURL.isEmpty, let url = URL(string: previewURL) else { return }
        isLoading = true
        let asset = AVURLAsset(url: url)
        guard (try? await asset.load(.duration)) != nil else {
            isLoading = false
            return
        }
        let avPlayer = AVPlayer(url: url)
        avPlayer.isMuted = true
        player = avPlayer
        isLoading = false
        avPlayer.play()
    }
}

// MARK: - Preview

#Preview {
    TemplateThumbnailView(previewURL: "")
        .frame(width: 300, height: 300)
}

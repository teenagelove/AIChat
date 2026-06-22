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

    // MARK: - Body

    var body: some View {
        if let url = URL(string: previewURL), !previewURL.isEmpty {
            VideoPlayerContainer(url: url)
                .clipShape(.rect(cornerRadius: 16))
        } else {
            Image(.imageMock)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipShape(.rect(cornerRadius: 16))
        }
    }
}

// MARK: - VideoPlayerContainer

private struct VideoPlayerContainer: UIViewControllerRepresentable {

    let url: URL

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        let player = AVPlayer(url: url)
        controller.player = player
        controller.showsPlaybackControls = false
        controller.videoGravity = .resizeAspect

        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: player.currentItem,
            queue: .main
        ) { _ in
            player.seek(to: .zero)
            player.play()
        }

        return controller
    }

    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        uiViewController.player?.play()
    }
}

// MARK: - Preview

#Preview {
    TemplateThumbnailView(previewURL: "")
        .frame(width: 300, height: 300)
}

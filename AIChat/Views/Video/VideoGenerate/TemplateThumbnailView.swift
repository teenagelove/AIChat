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
        controller.player = AVPlayer(url: url)
        controller.showsPlaybackControls = false
        controller.videoGravity = .resizeAspect
        return controller
    }

    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {}
}

// MARK: - Preview

#Preview {
    TemplateThumbnailView(previewURL: "")
        .frame(width: 300, height: 300)
}

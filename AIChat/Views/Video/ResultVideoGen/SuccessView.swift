//
//  SuccessView.swift
//  AIChat
//
//  Created by Danil Kazakov on 22.06.2026.
//

import SwiftUI
import AVKit

// MARK: - SuccessView

struct SuccessView: View {

    // MARK: - Properties

    let videoURL: URL
    let onReplace: () -> Void
    let onShare: () -> Void
    let onDownload: () -> Void

    // MARK: - State

    @State private var player: AVPlayer

    // MARK: - Init

    init(videoURL: URL, onReplace: @escaping () -> Void, onShare: @escaping () -> Void, onDownload: @escaping () -> Void) {
        self.videoURL = videoURL
        self.onReplace = onReplace
        self.onShare = onShare
        self.onDownload = onDownload
        self._player = State(initialValue: AVPlayer(url: videoURL))
    }

    // MARK: - Body

    var body: some View {
        VStack(spacing: 16) {
            ZStack(alignment: .topTrailing) {
                VideoPlayer(player: player)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .clipShape(.rect(cornerRadius: 24))

                ReplaceButton(action: onReplace)
                    .padding(12)
            }
            .padding(.top, 9.5)

            buttonsRow
        }
        .padding(.horizontal, 16)
    }
}

// MARK: - Private

private extension SuccessView {

    // MARK: - Buttons Row

    var buttonsRow: some View {
        HStack(spacing: 12) {
            shareButton
            downloadButton
        }
    }

    // MARK: - Share Button

    var shareButton: some View {
        ShareLink(item: videoURL) {
            Text(String(localized: .shareButton))
                .font(.semiBold16)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(Color(.card))
                .clipShape(.rect(cornerRadius: 24))
        }
    }

    // MARK: - Download Button

    var downloadButton: some View {
        Button(action: onDownload) {
            Text(String(localized: .downloadButton))
                .font(.semiBold16)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(LinearGradient.primaryGradient)
                .clipShape(.rect(cornerRadius: 24))
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Preview

#Preview {
    SuccessView(
        videoURL: URL(string: "https://example.com/video.mp4")!,
        onReplace: {},
        onShare: {},
        onDownload: {}
    )
    .background(Color.backgroundClr)
}

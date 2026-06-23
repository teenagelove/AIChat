//
//  VideoTemplateCardView.swift
//  AIChat
//
//  Created by Danil Kazakov on 20.06.2026.
//

import SwiftUI
import AVKit

// MARK: - VideoTemplateCardView

struct VideoTemplateCardView: View {

    // MARK: - Properties

    let title: String
    let previewURL: String
    private let action: (() -> Void)?

    // MARK: - State

    @State private var player: AVPlayer?

    // MARK: - Init

    init(title: String, previewURL: String, action: (() -> Void)? = nil) {
        self.title = title
        self.previewURL = previewURL
        self.action = action
    }

    // MARK: - Body

    var body: some View {
        Button { action?() } label: {
            ZStack(alignment: .bottom) {
                if let player = player {
                    VideoPlayer(player: player)
                        .aspectRatio(contentMode: .fill)
                        .disabled(true) // Disable player controls in grid
                } else {
                    Color(.card)
                        .aspectRatio(1, contentMode: .fill)
                }

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
        .buttonStyle(.plain)
        .task(id: previewURL) {
            guard let url = URL(string: previewURL) else { return }
            
            try? await Task.sleep(for: .milliseconds(300))
            if Task.isCancelled { return }
            
            let newPlayer = await Task.detached {
                AVPlayer(url: url)
            }.value
            
            if !Task.isCancelled {
                newPlayer.isMuted = true
                self.player = newPlayer
                newPlayer.play()
            }
        }
        .onDisappear {
            player?.pause()
            player?.replaceCurrentItem(with: nil)
            player = nil
        }
    }
}

// MARK: - Preview

#Preview {
    VideoTemplateCardView(title: "Title", previewURL: "")
        .frame(height: 280)
}

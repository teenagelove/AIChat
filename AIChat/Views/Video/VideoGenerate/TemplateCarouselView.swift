//
//  TemplateCarouselView.swift
//  AIChat
//
//  Created by Danil Kazakov on 22.06.2026.
//

import SwiftUI
import AVKit

// MARK: - TemplateCarouselView

struct TemplateCarouselView: View {

    // MARK: - Properties

    @Binding var selectedIndex: Int
    let templates: [VideoTemplate]

    // MARK: - State

    @State private var players: [Int: AVPlayer] = [:]
    @State private var isLoading: [Int: Bool] = [:]

    // MARK: - Body

    var body: some View {
        TabView(selection: $selectedIndex) {
            ForEach(Array(templates.enumerated()), id: \.element.id) { index, template in
                TemplateThumbnailView(player: players[index])
                    .tag(index)
                    .overlay {
                        if isLoading[index] == true {
                            ProgressView()
                                .tint(.white)
                        }
                    }
                    .onAppear {
                        loadPlayer(at: index, url: template.previewLarge)
                    }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(height: 331)
        .onChange(of: selectedIndex) { newIndex in
            updatePlayback(selectedIndex: newIndex)
        }
        .onAppear {
            updatePlayback(selectedIndex: selectedIndex)
        }
    }

    // MARK: - Private Methods

    private func loadPlayer(at index: Int, url: String) {
        guard players[index] == nil,
              let url = URL(string: url),
              !url.absoluteString.isEmpty
        else { return }

        isLoading[index] = true
        players[index] = AVPlayer(url: url)
        isLoading[index] = false

        if index == selectedIndex {
            players[index]?.play()
        }
    }

    private func updatePlayback(selectedIndex: Int) {
        for (index, player) in players {
            if index == selectedIndex {
                player.play()
            } else {
                player.pause()
                player.seek(to: .zero)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    TemplateCarouselView(selectedIndex: .constant(0), templates: VideoTemplate.mock)
}

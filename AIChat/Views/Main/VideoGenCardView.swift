//
//  VideoGenCardView.swift
//  AIChat
//
//  Created by Danil Kazakov on 20.06.2026.
//

import SwiftUI

struct VideoGenCardView: View {
    var body: some View {
        ZStack {
            Image(.videoBackground)
                .resizable()
                .clipShape(.rect(cornerRadius: 24))

            VStack {
                VStack(alignment: .leading) {
                    iconContainer

                    title

                    description

                    Spacer()
                }
                .padding()

                readyButton
                    .padding(.bottom)
            }
        }
    }
}

private extension VideoGenCardView {

    // MARK: - UI Components

    var title: some View {
        Text(.turnPhotoVideo)
            .font(.medium20)
    }

    var iconContainer: some View {
        ZStack {
            Color.white.opacity(0.15)
                .frame(width: 36, height: 36)
                .clipShape(Circle())

            Image(.imageIco)
                .resizable()
                .frame(width: 24, height: 24)
        }
    }

    var readyButton: some View {
        HStack(spacing: 8) {
            Text(.readyInSeconds)
                .font(.regular14)

            Image(.polygonIco)
                .resizable()
                .frame(width: 16, height: 16)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(Color.white.opacity(0.3))
        .clipShape(Capsule())
    }

    var description: some View {
        HStack(spacing: 6) {
            Text(.animate)
                .font(.regular14)

            Capsule()
                .frame(width: 4, height: 4)

            Text(.template)
                .font(.regular14)
        }
    }
}

#Preview {
    VideoGenCardView()
}

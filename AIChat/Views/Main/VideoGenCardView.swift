//
//  VideoGenCardView.swift
//  AIChat
//
//  Created by Danil Kazakov on 20.06.2026.
//

import SwiftUI

struct VideoGenCardView: View {
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                iconContainer

                title

                description
            }
            .padding(.horizontal, 16)

            readyButton
                .padding(.top, 116)
        }
        .padding(.top, 24)
        .padding(.bottom)
        .frame(maxWidth: .infinity)
        .background {
            Image(.videoBackground)
                .resizable()
                .scaledToFill()
        }
        .clipShape(.rect(cornerRadius: 24))
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
        .opacity(0.7)
    }
}

#Preview {
    VideoGenCardView()
}

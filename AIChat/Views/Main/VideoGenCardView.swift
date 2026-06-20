//
//  VideoGenCardView.swift
//  AIChat
//
//  Created by Danil Kazakov on 20.06.2026.
//

import SwiftUI

struct VideoGenCardView: View {
    var body: some View {
        content
            .background(backgroundImage)
            .clipShape(.rect(cornerRadius: 24))
    }
}

private extension VideoGenCardView {

    // MARK: - Layout

    var content: some View {
        VStack(alignment: .leading, spacing: 0) {
            iconContainer
                .padding(.top, 20)
                .padding(.leading, 20)

            Spacer(minLength: 16)

            title
                .padding(.leading, 20)

            description
                .padding(.top, 6)
                .padding(.leading, 20)

            Spacer()

            readyButton
                .padding(.leading, 20)
                .padding(.bottom, 20)
        }
    }

    // MARK: - UI Components

    var backgroundImage: some View {
        Image(.videoBackground)
            .resizable()
    }

    var iconContainer: some View {
        ZStack {
            Color.white.opacity(0.15)
                .frame(width: 48, height: 48)
                .clipShape(RoundedRectangle(cornerRadius: 12))

            Image(.imageIco)
                .resizable()
                .frame(width: 24, height: 24)
        }
    }

    var title: some View {
        Text(.turnPhotoVideo)
            .font(.medium20)
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

    var readyButton: some View {
        HStack(spacing: 8) {
            Text(.readyInSeconds)
                .font(.regular14)

            Image(.polygonIco)
                .resizable()
                .frame(width: 16, height: 16)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(Color.white.opacity(0.3))
        .clipShape(Capsule())
    }
}

#Preview {
    VideoGenCardView()
}

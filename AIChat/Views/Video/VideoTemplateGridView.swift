//
//  VideoTemplateGridView.swift
//  AIChat
//
//  Created by Danil Kazakov on 20.06.2026.
//

import SwiftUI

// MARK: - VideoTemplateGridView

struct VideoTemplateGridView: View {

    // MARK: - Properties

    let templates: [VideoTemplate]

    // MARK: - Body

    var body: some View {
        LazyVGrid(columns: [
            GridItem(.flexible(), spacing: 12),
            GridItem(.flexible(), spacing: 12)
        ], spacing: 12) {
            ForEach(templates) { template in
                VideoTemplateCardView(
                    title: template.title,
                    image: template.image
                )
            }
        }
    }
}

// MARK: - Preview

#Preview {
    VideoTemplateGridView(templates: VideoTemplate.mock)
}

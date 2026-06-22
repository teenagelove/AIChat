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
    let onTemplateTap: ((VideoTemplate) -> Void)?

    // MARK: - Init

    init(templates: [VideoTemplate], onTemplateTap: ((VideoTemplate) -> Void)? = nil) {
        self.templates = templates
        self.onTemplateTap = onTemplateTap
    }

    // MARK: - Body

    var body: some View {
        LazyVGrid(columns: [
            GridItem(.flexible(), spacing: 12),
            GridItem(.flexible(), spacing: 12)
        ], spacing: 12) {
            ForEach(templates) { template in
                VideoTemplateCardView(
                    title: template.title,
                    image: template.image,
                    action: { onTemplateTap?(template) }
                )
            }
        }
    }
}

// MARK: - Preview

#Preview {
    VideoTemplateGridView(templates: VideoTemplate.mock)
}

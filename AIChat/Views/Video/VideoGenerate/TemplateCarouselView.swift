//
//  TemplateCarouselView.swift
//  AIChat
//
//  Created by Danil Kazakov on 22.06.2026.
//

import SwiftUI

// MARK: - TemplateCarouselView

struct TemplateCarouselView: View {

    // MARK: - Properties

    @Binding var selectedIndex: Int
    let templates: [VideoTemplate]

    // MARK: - Body

    var body: some View {
        TabView(selection: $selectedIndex) {
            ForEach(Array(templates.enumerated()), id: \.element.id) { index, template in
                TemplateThumbnailView(previewURL: template.previewLarge)
                    .tag(index)
                    .padding()
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(height: 331)
    }
}

// MARK: - Preview

#Preview {
    TemplateCarouselView(selectedIndex: .constant(0), templates: VideoTemplate.mock)
}

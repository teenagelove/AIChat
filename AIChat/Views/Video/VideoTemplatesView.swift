//
//  VideoTemplatesView.swift
//  AIChat
//
//  Created by Danil Kazakov on 20.06.2026.
//

import SwiftUI

// MARK: - VideoTemplatesView

struct VideoTemplatesView: View {

    // MARK: - Dependencies

    @EnvironmentObject private var coordinator: Coordinator
    @State private var selectedCategory: VideoCategory = .popular

    // MARK: - Body

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                CategoryTabsView(selectedCategory: $selectedCategory)

                VideoTemplateGridView(templates: filteredTemplates)
            }
            .padding(.horizontal, 16)
            .padding(.top, 24)
        }
        .background(Color.backgroundClr.ignoresSafeArea(edges: .bottom))
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButtonView {
                    coordinator.goBack()
                }
            }

            ToolbarItem(placement: .topBarLeading) {
                HStack(spacing: 12) {
                    Image(.imageIco)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding(4)
                        .background(LinearGradient.primaryGradient)
                        .clipShape(Circle())

                    Text(.videoTemplatesTitle)
                        .font(.semiBold20)
                }
            }

            ToolbarItem(placement: .topBarTrailing) {
                ForwardButtonView {
                    coordinator.goBack()
                }
            }
        }
    }
}

private extension VideoTemplatesView {

    // MARK: - Properties

    var filteredTemplates: [VideoTemplate] {
        VideoTemplate.mock.filter { $0.category == selectedCategory }
    }
}

// MARK: - Preview

#Preview {
    VideoTemplatesView()
        .environmentObject(Coordinator())
}

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
        ZStack {
            Color.backgroundClr

            VStack(spacing: 0) {
                categoryTabs

                templateGrid
            }
            .padding()
        }
        .ignoresSafeArea(edges: .bottom)
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

    // MARK: - UI Components

    var categoryTabs: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 12) {
                ForEach(VideoCategory.allCases) { category in
                    categoryTab(category)
                }
            }
        }
    }

    func categoryTab(_ category: VideoCategory) -> some View {
        Button {
            selectedCategory = category
        } label: {
            Text(category.rawValue)
                .font(.medium14)
                .foregroundStyle(selectedCategory == category ? .white : .white.opacity(0.6))
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
                .background(selectedCategory == category ? LinearGradient.primaryGradient : LinearGradient(colors: [.card], startPoint: .leading, endPoint: .trailing))
                .clipShape(Capsule())
        }

    }

    var templateGrid: some View {
        ScrollView {
            LazyVGrid(columns: [
                GridItem(.flexible(), spacing: 12),
                GridItem(.flexible(), spacing: 12)
            ], spacing: 12) {
                ForEach(filteredTemplates) { template in
                    VideoTemplateCardView(
                        title: template.title,
                        image: template.image
                    )
                }
            }
        }
    }

    var filteredTemplates: [VideoTemplate] {
        VideoTemplate.mock.filter { $0.category == selectedCategory }
    }
}

// MARK: - Preview

#Preview {
    VideoTemplatesView()
        .environmentObject(Coordinator())
}

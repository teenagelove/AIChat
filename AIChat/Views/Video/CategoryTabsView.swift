//
//  CategoryTabsView.swift
//  AIChat
//
//  Created by Danil Kazakov on 20.06.2026.
//

import SwiftUI

// MARK: - CategoryTabsView

struct CategoryTabsView: View {

    // MARK: - Properties

    @Binding var selectedCategory: VideoCategory

    // MARK: - Body

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 12) {
                ForEach(VideoCategory.allCases) { category in
                    categoryTab(category)
                }
            }
        }
    }
}

private extension CategoryTabsView {

    // MARK: - UI Components

    func categoryTab(_ category: VideoCategory) -> some View {
        Button {
            selectedCategory = category
        } label: {
            Text(category.rawValue)
                .font(.medium14)
                .foregroundStyle(selectedCategory == category ? .white : .white.opacity(0.5))
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(selectedCategory == category ? LinearGradient.primaryGradient : LinearGradient(colors: [.card], startPoint: .leading, endPoint: .trailing))
                .clipShape(Capsule())
        }
    }
}

// MARK: - Preview

#Preview {
    CategoryTabsView(selectedCategory: .constant(.popular))
}

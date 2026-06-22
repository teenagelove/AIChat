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
    @StateObject private var viewModel = VideoTemplatesViewModel()

    // MARK: - Body

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                CategoryTabsView(selectedCategory: $viewModel.selectedCategory)

                VideoTemplateGridView(
                    templates: viewModel.filteredTemplates,
                    onTemplateTap: { _ in viewModel.isShowingPermissionAlert = true }
                )
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
        .alert(.photoAccessTitle, isPresented: $viewModel.isShowingPermissionAlert) {
            Button(.cancel, role: .cancel) {
                coordinator.goBack()
            }
            Button(.allow) { viewModel.requestPhotoAccess() }
        } message: {
            Text(.photoAccessMessage)
        }
    }
}

// MARK: - Preview

#Preview {
    VideoTemplatesView()
        .environmentObject(Coordinator())
}

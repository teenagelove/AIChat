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
    @StateObject private var viewModel: VideoTemplatesViewModel
    @State private var isShowingNotImplemented = false

    // MARK: - Init

    init(videoService: any VideoGenerationServiceProtocol = VideoGenerationService()) {
        _viewModel = StateObject(wrappedValue: VideoTemplatesViewModel(videoService: videoService))
    }

    // MARK: - Body

    var body: some View {
        ZStack {
            switch viewModel.state {
            case .idle, .loading:
                CustomProgressView()

            case .error(let message):
                ErrorView(message: message) {
                    Task { await viewModel.loadTemplates() }
                }

            case .loaded:
                mainContent
            }
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
                    isShowingNotImplemented = true
                }
            }
        }
        .alert(.notImplementedTitle, isPresented: $isShowingNotImplemented) {
            Button(.ok, role: .cancel) {}
        } message: {
            Text(.notImplementedMessage)
        }
        .task {
            await viewModel.loadTemplates()
        }
        .onReceive(viewModel.$templateToNavigate) { template in
            guard let template else { return }
            coordinator.navigate(to: .videoGenerate(template))
            viewModel.resetNavigation()
        }
        .alert(.photoAccessTitle, isPresented: $viewModel.isShowingPermissionAlert) {
            Button(.cancel, role: .cancel) {
                viewModel.cancelPermission()
                coordinator.popToRoot()
            }
            Button(.allow) {
                viewModel.confirmAllow()
            }
        } message: {
            Text(.photoAccessMessage)
        }
    }
}

// MARK: - Private

private extension VideoTemplatesView {

    var mainContent: some View {
        ScrollView {
            VStack(spacing: 24) {
                CategoryTabsView(
                    selectedCategory: $viewModel.selectedCategory,
                    categories: viewModel.categories
                )

                VideoTemplateGridView(
                    templates: viewModel.filteredTemplates,
                    onTemplateTap: { template in viewModel.onTemplateTap(template) }
                )
            }
            .padding(.horizontal, 16)
            .padding(.top, 24)
        }
    }
}

// MARK: - Preview

#Preview {
    VideoTemplatesView()
        .environmentObject(Coordinator())
}

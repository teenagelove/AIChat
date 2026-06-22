//
//  ResultVideoGenView.swift
//  AIChat
//
//  Created by Danil Kazakov on 22.06.2026.
//

import SwiftUI

// MARK: - ResultVideoGenView

struct ResultVideoGenView: View {

    // MARK: - Dependencies

    @EnvironmentObject private var coordinator: Coordinator
    @ObservedObject var viewModel: VideoGenerateViewModel

    // MARK: - Body

    var body: some View {
        mainContent
            .overlay { toastOverlay }
            .background(Color.backgroundClr.ignoresSafeArea(edges: .bottom))
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    BackButtonView {
                        if case .generating = viewModel.generationState {
                            viewModel.resetGeneration()
                        }
                        coordinator.goBack()
                    }
                }

                if case .success = viewModel.generationState {
                    ToolbarItem(placement: .principal) {
                        Text(String(localized: .resultTitle))
                            .font(.semiBold20)
                    }
                }
            }
    }
}

// MARK: - Private

private extension ResultVideoGenView {

    // MARK: - Main Content

    @ViewBuilder
    var mainContent: some View {
        switch viewModel.generationState {
        case .idle, .generating:
            GeneratingView()

        case .success(let videoUrl):
            if let videoURL = URL(string: videoUrl) {
                SuccessView(
                    videoURL: videoURL,
                    onReplace: { Task { await viewModel.regenerateVideo() } },
                    onShare: {},
                    onDownload: { Task { await viewModel.downloadVideo() } }
                )
            }

        case .error(let message):
            ErrorView(message: message) {
                viewModel.resetGeneration()
                coordinator.goBack()
            }
        }
    }

    // MARK: - Toast Overlay

    var toastOverlay: some View {
        ToastView(
            message: viewModel.toastMessage ?? "",
            isSuccess: viewModel.toastIsSuccess
        )
        .opacity(viewModel.toastMessage != nil ? 1 : 0)
        .animation(.easeInOut(duration: 0.3), value: viewModel.toastMessage != nil)
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        ResultVideoGenView(
            viewModel: VideoGenerateViewModel(
                template: VideoTemplate.mock[0],
                allTemplates: VideoTemplate.mock,
                videoService: VideoGenerationService()
            )
        )
        .environmentObject(Coordinator())
    }
}

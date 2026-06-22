//
//  VideoGenerateView.swift
//  AIChat
//
//  Created by Danil Kazakov on 21.06.2026.
//

import SwiftUI
import PhotosUI

// MARK: - VideoGenerateView

struct VideoGenerateView: View {

    // MARK: - Dependencies

    @EnvironmentObject private var coordinator: Coordinator
    @StateObject private var viewModel: VideoGenerateViewModel
    @State private var isShowingNotImplemented = false

    // MARK: - Init

    init(template: VideoTemplate, allTemplates: [VideoTemplate] = VideoTemplate.mock, videoService: any VideoGenerationServiceProtocol = VideoGenerationService()) {
        _viewModel = StateObject(wrappedValue: VideoGenerateViewModel(template: template, allTemplates: allTemplates, videoService: videoService))
    }

    // MARK: - Body

    var body: some View {
        ZStack {
            mainContent

            if viewModel.showingFormatPicker || viewModel.showingQualityPicker {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                    .onTapGesture {
                        viewModel.showingFormatPicker = false
                        viewModel.showingQualityPicker = false
                    }

                if viewModel.showingFormatPicker {
                    FormatMenuView(
                        selectedFormat: $viewModel.selectedFormat,
                        isPresented: $viewModel.showingFormatPicker
                    )
                }

                if viewModel.showingQualityPicker {
                    QualityMenuView(
                        selectedQuality: $viewModel.selectedQuality,
                        isPresented: $viewModel.showingQualityPicker,
                        availableQualities: viewModel.availableQualities
                    )
                }
            }
        }
        .background(Color.backgroundClr.ignoresSafeArea(edges: .bottom))
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButtonView { coordinator.goBack() }
            }

            ToolbarItem(placement: .principal) {
                Text(viewModel.currentTemplate.name)
                    .font(.semiBold20)
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
        .photosPicker(
            isPresented: Binding(
                get: { viewModel.activePhotoSlot != nil },
                set: { _ in }
            ),
            selection: $viewModel.photoPickerItem,
            matching: .images
        )
        .onChange(of: viewModel.photoPickerItem) { item in
            if let item {
                Task {
                    await viewModel.loadPhotoFromItem(item)
                }
            }
        }
        .navigationDestination(isPresented: $viewModel.isShowingResult) {
            ResultVideoGenView(viewModel: viewModel)
        }
    }
}

// MARK: - Private

private extension VideoGenerateView {

    // MARK: - UI Components

    var mainContent: some View {
        ScrollView {
            VStack(spacing: 24) {
                TemplateCarouselView(
                    selectedIndex: $viewModel.selectedTemplateIndex,
                    templates: viewModel.allTemplates
                )
                .onChange(of: viewModel.selectedTemplateIndex) { index in
                    viewModel.selectTemplate(at: index)
                }

                PhotoSlotsView(
                    supportedCount: 1,
                    selectedImages: viewModel.selectedImages,
                    isLoadingIndex: viewModel.isLoadingPhotoIndex,
                    onSlotTap: { viewModel.openPhotoPicker(for: $0) }
                )

                formatQualitySection

                createButton
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
        }
    }

    var formatQualitySection: some View {
        VStack(spacing: 12) {
            DropdownRow(
                isPresented: $viewModel.showingFormatPicker,
                label: String(localized: .formatLabel),
                value: viewModel.selectedFormat.rawValue
            )

            DropdownRow(
                isPresented: $viewModel.showingQualityPicker,
                label: String(localized: .qualityLabel),
                value: viewModel.selectedQuality.rawValue
            )
        }
    }

    var createButton: some View {
        Button {
            Task { await viewModel.generateVideo() }
        } label: {
            if viewModel.generationState == .generating {
                ProgressView()
                    .tint(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(LinearGradient.primaryGradient)
                    .clipShape(.rect(cornerRadius: 24))
            } else {
                Text(String(localized: .createButton))
                    .font(.semiBold18)
                    .foregroundStyle(viewModel.isCreateEnabled ? .white : .gray)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(
                        viewModel.isCreateEnabled
                        ? LinearGradient.primaryGradient
                        : LinearGradient(colors: [Color(.card)], startPoint: .leading, endPoint: .trailing)
                    )
                    .clipShape(.rect(cornerRadius: 24))
            }
        }
        .buttonStyle(.plain)
        .disabled(!viewModel.isCreateEnabled)
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        VideoGenerateView(template: VideoTemplate.mock[0])
            .environmentObject(Coordinator())
    }
}

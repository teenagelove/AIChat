//
//  VideoGenerateViewModel.swift
//  AIChat
//
//  Created by Danil Kazakov on 21.06.2026.
//

import SwiftUI
import PhotosUI
import Photos
import Combine

// MARK: - VideoGenerateViewModel

@MainActor
final class VideoGenerateViewModel: ObservableObject {

    // MARK: - State

    enum GenerationState: Equatable {
        case idle
        case generating
        case success(String)
        case error(String)
    }

    // MARK: - Published

    @Published var selectedFormat: VideoFormat = .horizontal
    @Published var selectedQuality: VideoQuality
    @Published var selectedImages: [Int: UIImage] = [:]
    @Published var isLoadingPhotoIndex: Int?
    @Published var selectedTemplateIndex: Int
    @Published var currentTemplate: VideoTemplate
    @Published var photoPickerItem: PhotosPickerItem?
    @Published var activePhotoSlot: Int?
    @Published var showingFormatPicker = false
    @Published var showingQualityPicker = false
    @Published var generationState: GenerationState = .idle
    @Published var isShowingResult = false
    @Published var toastMessage: String?
    @Published var toastIsSuccess = true

    // MARK: - Properties

    let allTemplates: [VideoTemplate]

    var availableQualities: [VideoQuality] {
        let qualities = currentTemplate.qualities.compactMap { VideoQuality(rawValue: $0) }
        return qualities.isEmpty ? VideoQuality.allCases : qualities
    }

    var isCreateEnabled: Bool {
        guard !selectedImages.isEmpty else { return false }
        if case .generating = generationState { return false }
        return true
    }

    // MARK: - Dependencies

    private let videoService: any VideoGenerationServiceProtocol

    // MARK: - Init

    init(
        template: VideoTemplate,
        allTemplates: [VideoTemplate],
        videoService: any VideoGenerationServiceProtocol
    ) {
        self.currentTemplate = template
        self.allTemplates = allTemplates
        self.videoService = videoService
        self.selectedTemplateIndex = allTemplates.firstIndex(where: { $0.id == template.id }) ?? 0
        let qualities = template.qualities.compactMap { VideoQuality(rawValue: $0) }
        self.selectedQuality = qualities.last ?? .hd1080
    }

    // MARK: - Functions

    func selectTemplate(at index: Int) {
        guard allTemplates.indices.contains(index) else { return }
        currentTemplate = allTemplates[index]
        if !availableQualities.contains(selectedQuality) {
            selectedQuality = availableQualities.last ?? .hd1080
        }
    }

    func openPhotoPicker(for slotIndex: Int) {
        activePhotoSlot = slotIndex
    }

    func loadPhotoFromItem(_ item: PhotosPickerItem) async {
        guard let slot = activePhotoSlot else { return }
        isLoadingPhotoIndex = slot

        let image = await loadImage(for: item)

        if let image {
            selectedImages[slot] = image
        }

        isLoadingPhotoIndex = nil
        activePhotoSlot = nil
        photoPickerItem = nil
    }

    func generateVideo() async {
        guard let image = selectedImages.first?.value else { return }

        generationState = .generating
        isShowingResult = true

        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            generationState = .error(String(localized: .videoGenCompressError))
            return
        }

        do {
            let response = try await videoService.template2Video(
                templateId: currentTemplate.templateId,
                imageData: imageData,
                fileName: "photo.jpg",
                prompt: currentTemplate.name,
                duration: currentTemplate.duration,
                quality: selectedQuality.rawValue
            )

            let statusResponse = try await videoService.getGenerationStatus(videoId: response.videoId)

            if let url = statusResponse.videoUrl {
                generationState = .success(url)
            } else {
                generationState = .error(String(localized: .videoGenUrlMissing))
            }
        } catch {
            generationState = .error(error.localizedDescription)
        }
    }

    func regenerateVideo() async {
        await generateVideo()
    }

    func downloadVideo() async {
        guard case .success(let urlString) = generationState,
              let url = URL(string: urlString) else { return }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let tempURL = temporaryFileURL(data)
            try await PHPhotoLibrary.shared().performChanges {
                PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: tempURL)
            }
            toastMessage = String(localized: .videoSavedSuccess)
            toastIsSuccess = true
            hideToastAfterDelay()
        } catch {
            toastMessage = String(localized: .videoSavedError)
            toastIsSuccess = false
            hideToastAfterDelay()
        }
    }

    func hideToast() {
        toastMessage = nil
    }

    func resetGeneration() {
        generationState = .idle
        isShowingResult = false
        toastMessage = nil
    }
}

private extension VideoGenerateViewModel {

    // MARK: - Private Methods

    func hideToastAfterDelay() {
        Task {
            try? await Task.sleep(for: .seconds(2))
            toastMessage = nil
        }
    }

    func temporaryFileURL(_ data: Data) -> URL {
        let tempDir = FileManager.default.temporaryDirectory
        let fileURL = tempDir.appendingPathComponent("video_\(UUID().uuidString).mp4")
        try? data.write(to: fileURL)
        return fileURL
    }

    func loadImage(for item: PhotosPickerItem) async -> UIImage? {
        if let data = try? await item.loadTransferable(type: Data.self), let image = UIImage(data: data) {
            return image
        }

        return nil
    }
}

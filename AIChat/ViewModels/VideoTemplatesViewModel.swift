//
//  VideoTemplatesViewModel.swift
//  AIChat
//
//  Created by Danil Kazakov on 20.06.2026.
//

import Combine
import Photos
import UIKit

// MARK: - VideoTemplatesViewModel

@MainActor
final class VideoTemplatesViewModel: ObservableObject {

    // MARK: - State

    enum State {
        case idle
        case loading
        case loaded([VideoTemplate])
        case error(String)
    }

    // MARK: - Published

    @Published var state: State = .idle
    @Published var selectedCategory: VideoCategory = .init(id: "", displayName: "Trending")
    @Published var isShowingPermissionAlert = false
    @Published var templateToNavigate: VideoTemplate?

    // MARK: - Dependencies

    private let videoService: any VideoGenerationServiceProtocol

    // MARK: - Private

    private var pendingTemplate: VideoTemplate?
    private var allTemplates: [VideoTemplate] = []

    // MARK: - Computed

    var categories: [VideoCategory] {
        let grouped = Dictionary(grouping: allTemplates, by: { $0.category })
        return grouped.keys
            .map { VideoCategory(rawValue: $0) }
            .sorted { $0.displayName < $1.displayName }
    }

    var filteredTemplates: [VideoTemplate] {
        allTemplates.filter { $0.category == selectedCategory.id }
    }

    // MARK: - Init

    init(videoService: any VideoGenerationServiceProtocol) {
        self.videoService = videoService
    }

    // MARK: - Functions

    func loadTemplates() async {
        state = .loading

        do {
            let templates = try await videoService.getTemplates()
            allTemplates = templates
            if let first = categories.first {
                selectedCategory = first
            }
            state = .loaded(templates)
        } catch {
            state = .error(error.localizedDescription)
        }
    }

    func onTemplateTap(_ template: VideoTemplate) {
        let status = PHPhotoLibrary.authorizationStatus(for: .readWrite)

        switch status {
        case .authorized, .limited:
            templateToNavigate = template

        case .notDetermined, .denied, .restricted:
            pendingTemplate = template
            isShowingPermissionAlert = true

        @unknown default:
            pendingTemplate = nil
        }
    }

    func confirmAllow() {
        guard let pendingTemplate else { return }
        let template = pendingTemplate
        self.pendingTemplate = nil

        let status = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        if status == .denied || status == .restricted {
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
            return
        }

        Task {
            let newStatus = await PHPhotoLibrary.requestAuthorization(for: .readWrite)

            switch newStatus {
            case .authorized, .limited:
                self.templateToNavigate = template

            default:
                self.templateToNavigate = nil
            }
        }
    }

    func cancelPermission() {
        pendingTemplate = nil
    }

    func resetNavigation() {
        templateToNavigate = nil
    }
}

//
//  VideoTemplatesViewModel.swift
//  AIChat
//
//  Created by Danil Kazakov on 20.06.2026.
//

import Combine
import Photos

// MARK: - VideoTemplatesViewModel

@MainActor
final class VideoTemplatesViewModel: ObservableObject {

    // MARK: - State

    @Published var selectedCategory: VideoCategory = .popular
    @Published var isShowingPermissionAlert = false

    // MARK: - Properties

    var filteredTemplates: [VideoTemplate] {
        VideoTemplate.mock.filter { $0.category == selectedCategory }
    }

    // MARK: - Photo Permission

    func requestPhotoAccess() {
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
            guard status == .authorized || status == .limited else { return }
            Task { @MainActor in
                // TODO: Navigate to next screen
            }
        }
    }
}

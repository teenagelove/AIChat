//
//  VideoGenerationServiceProtocol.swift
//  AIChat
//
//  Created by Danil Kazakov on 22.06.2026.
//

import Foundation

// MARK: - VideoGenerationServiceProtocol

protocol VideoGenerationServiceProtocol {
    func getTemplates() async throws -> [VideoTemplate]
    func template2Video(templateId: Int, imageData: Data, fileName: String, prompt: String?, duration: Int?, quality: String?) async throws -> PixverseGenerationResponse
    func getGenerationStatus(videoId: Int) async throws -> PixverseGenerationStatusResponse
}

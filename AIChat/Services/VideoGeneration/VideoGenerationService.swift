//
//  VideoGenerationService.swift
//  AIChat
//
//  Created by Danil Kazakov on 22.06.2026.
//

import Foundation

// MARK: - VideoGenerationService

final class VideoGenerationService: VideoGenerationServiceProtocol {

    // MARK: - Dependencies

    private let session: URLSession
    private let decoder: JSONDecoder

    // MARK: - Init

    init(session: URLSession = .shared) {
        self.session = session
        self.decoder = JSONDecoder()
        self.decoder.keyDecodingStrategy = .convertFromSnakeCase
    }

    // MARK: - Templates

    func getTemplates() async throws -> [VideoTemplate] {
        let request = try GetTemplatesRequest(appId: Constants.Dola.appId).build()
        let (data, response) = try await session.data(for: request)
        try HTTPResponseValidator.validate(response)
        let decoded = try decoder.decode(TemplatesResponse.self, from: data)
        return decoded.templates
    }

    // MARK: - Generation

    func template2Video(templateId: Int, imageData: Data, fileName: String, prompt: String?, duration: Int?, quality: String?) async throws -> PixverseGenerationResponse {
        let request = try Template2VideoRequest(
            templateId: templateId,
            imageData: imageData,
            fileName: fileName,
            prompt: prompt,
            duration: duration,
            quality: quality
        ).buildMultipartRequest()
        let (data, response) = try await session.data(for: request)
        try HTTPResponseValidator.validate(response)
        return try decoder.decode(PixverseGenerationResponse.self, from: data)
    }

    // MARK: - Status

    func getGenerationStatus(videoId: Int) async throws -> PixverseGenerationStatusResponse {
        let request = try GetVideoStatusRequest(videoId: videoId).build()
        let (data, response) = try await session.data(for: request)
        try HTTPResponseValidator.validate(response)
        return try decoder.decode(PixverseGenerationStatusResponse.self, from: data)
    }
}

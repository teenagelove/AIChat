//
//  GetVideoStatusRequest.swift
//  AIChat
//
//  Created by Danil Kazakov on 22.06.2026.
//

import Foundation

// MARK: - GetVideoStatusRequest

struct GetVideoStatusRequest: NetworkRequest {
    let videoId: Int

    var path: String {
        "\(Constants.PixVerse.basePath)/api/v1/status"
    }

    var method: HTTPMethod { .get }

    var queryItems: [URLQueryItem] {
        baseQueryItems + [
            URLQueryItem(name: "id", value: String(videoId))
        ]
    }

    var headers: [String: String] {
        ["Authorization": "Bearer \(Constants.Dola.bearerToken)"]
    }
}

//
//  GetTemplatesRequest.swift
//  AIChat
//
//  Created by Danil Kazakov on 22.06.2026.
//

import Foundation

// MARK: - GetTemplatesRequest

struct GetTemplatesRequest: NetworkRequest {
    let appId: String

    var path: String {
        "\(Constants.PixVerse.basePath)/api/v1/get_templates/\(appId)"
    }

    var method: HTTPMethod { .get }

    var headers: [String: String] {
        ["Authorization": "Bearer \(Constants.Dola.bearerToken)"]
    }
}

//
//  HTTPResponseValidator.swift
//  AIChat
//
//  Created by Danil Kazakov on 22.06.2026.
//

import Foundation

// MARK: - HTTPResponseValidator

enum HTTPResponseValidator {

    static func validate(_ response: URLResponse) throws {
        guard let http = response as? HTTPURLResponse,
              (200..<300).contains(http.statusCode) else {
            throw URLError(.badServerResponse)
        }
    }
}

//
//  TemplatesResponse.swift
//  AIChat
//
//  Created by Danil Kazakov on 22.06.2026.
//

import Foundation

// MARK: - TemplatesResponse

struct TemplatesResponse: Decodable {
    let id: Int
    let templates: [VideoTemplate]
}

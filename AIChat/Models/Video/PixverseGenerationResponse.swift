//
//  PixverseGenerationResponse.swift
//  AIChat
//
//  Created by Danil Kazakov on 22.06.2026.
//

import Foundation

// MARK: - PixverseGenerationResponse

struct PixverseGenerationResponse: Decodable {
    let videoId: Int
    let detail: String
}

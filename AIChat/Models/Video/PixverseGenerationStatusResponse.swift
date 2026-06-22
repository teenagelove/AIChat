//
//  PixverseGenerationStatusResponse.swift
//  AIChat
//
//  Created by Danil Kazakov on 22.06.2026.
//

import Foundation

// MARK: - PixverseGenerationStatusResponse

struct PixverseGenerationStatusResponse: Decodable {
    let status: String
    let videoUrl: String?
}

//
//  VideoFormat.swift
//  AIChat
//
//  Created by Danil Kazakov on 21.06.2026.
//

import SwiftUI

// MARK: - VideoFormat

enum VideoFormat: String, CaseIterable, Identifiable {
    case horizontal = "16:9"
    case vertical = "4:3"
    case square = "1:1"

    var id: String { rawValue }

    func icon(isSelected: Bool) -> some View {
        Group {
            switch self {
            case .horizontal:
                if isSelected {
                    RoundedRectangle(cornerRadius: 2)
                        .strokeBorder(LinearGradient.primaryGradient, lineWidth: 1.5)
                        .frame(width: 22, height: 14)
                } else {
                    RoundedRectangle(cornerRadius: 2)
                        .strokeBorder(Color.white, lineWidth: 1.5)
                        .frame(width: 22, height: 14)
                }
            case .vertical:
                if isSelected {
                    RoundedRectangle(cornerRadius: 2)
                        .strokeBorder(LinearGradient.primaryGradient, lineWidth: 1.5)
                        .frame(width: 14, height: 22)
                } else {
                    RoundedRectangle(cornerRadius: 2)
                        .strokeBorder(Color.white, lineWidth: 1.5)
                        .frame(width: 14, height: 22)
                }
            case .square:
                if isSelected {
                    RoundedRectangle(cornerRadius: 2)
                        .strokeBorder(LinearGradient.primaryGradient, lineWidth: 1.5)
                        .frame(width: 18, height: 18)
                } else {
                    RoundedRectangle(cornerRadius: 2)
                        .strokeBorder(Color.white, lineWidth: 1.5)
                        .frame(width: 18, height: 18)
                }
            }
        }
    }
}

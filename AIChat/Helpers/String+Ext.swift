//
//  String+Ext.swift
//  AIChat
//
//  Created by Danil Kazakov on 20.06.2026.
//

import Foundation

// MARK: - String + Chat Formatting

extension String {

    var hasTitle: Bool {
        contains(":")
    }

    var title: String {
        guard let range = range(of: ":") else { return "" }
        return String(self[..<range.lowerBound]).trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var body: String {
        guard let range = range(of: ":") else { return self }
        return String(self[range.upperBound...]).trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

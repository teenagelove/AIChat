//
//  Date+GroupKey.swift
//  AIChat
//
//  Created by Danil Kazakov on 20.06.2026.
//

import Foundation

// MARK: - Date

extension Date {

    var chatGroupKey: String {
        let calendar = Calendar.current
        if calendar.isDateInToday(self) {
            return String(localized: "today")
        } else if calendar.isDateInYesterday(self) {
            return String(localized: "yesterday")
        } else {
            return Self.groupKeyFormatter.string(from: self)
        }
    }

    private static let groupKeyFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d"
        return formatter
    }()
}

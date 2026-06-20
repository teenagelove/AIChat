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
            return "Today"
        } else if calendar.isDateInYesterday(self) {
            return "Yesterday"
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMMM d"
            return formatter.string(from: self)
        }
    }
}

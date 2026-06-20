//
//  GetMessagesRequest.swift
//  AIChat
//
//  Created by Danil Kazakov on 20.06.2026.
//

import Foundation

// MARK: - GetMessagesRequest

struct GetMessagesRequest: NetworkRequest {
    let chatId: String
    let limit: Int?
    let offset: Int

    var path: String { "/dola/chats/\(chatId)/messages" }
    var method: HTTPMethod { .get }

    var queryItems: [URLQueryItem] {
        var items = baseQueryItems
        items.append(URLQueryItem(name: "offset", value: "\(offset)"))
        if let limit {
            items.append(URLQueryItem(name: "limit", value: "\(limit)"))
        }
        return items
    }

    var headers: [String: String] {
        ["Authorization": "Bearer \(Constants.Dola.bearerToken)"]
    }
}

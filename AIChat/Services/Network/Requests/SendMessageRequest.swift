//
//  SendMessageRequest.swift
//  AIChat
//
//  Created by Danil Kazakov on 20.06.2026.
//

import Foundation

// MARK: - SendMessageRequest

struct SendMessageRequest: NetworkRequest {
    let chatId: String
    let message: String
    let locale: String?

    var path: String { "/dola/chats/\(chatId)/messages" }
    var method: HTTPMethod { .post }

    var queryItems: [URLQueryItem] {
        var items = baseQueryItems
        if let locale {
            items.append(URLQueryItem(name: "locale", value: locale))
        }
        return items
    }

    var headers: [String: String] {
        ["Authorization": "Bearer \(Constants.Dola.bearerToken)"]
    }

    var body: [String: Any]? { ["message": message] }
}

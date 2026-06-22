//
//  NetworkRequest+Ext.swift
//  AIChat
//
//  Created by Danil Kazakov on 20.06.2026.
//

import ApphudSDK
import Foundation

// MARK: - Default Values

extension NetworkRequest {

    var queryItems: [URLQueryItem] { [] }
    var headers: [String: String] { [:] }
    var body: [String: Any]? { nil }
}

// MARK: - Build

extension NetworkRequest {

    func build() throws -> URLRequest {
        guard var components = URLComponents(string: "\(Constants.Dola.baseURL)\(path)") else {
            throw URLError(.badURL)
        }
        components.queryItems = queryItems

        guard let url = components.url else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }

        if let body {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
        }

        return request
    }

    var baseQueryItems: [URLQueryItem] {
        [
            URLQueryItem(name: "user_id", value: Apphud.userID()),
            URLQueryItem(name: "app_id", value: Constants.Dola.appId)
        ]
    }
}

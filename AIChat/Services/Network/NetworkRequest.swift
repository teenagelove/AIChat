//
//  NetworkRequest.swift
//  AIChat
//
//  Created by Danil Kazakov on 20.06.2026.
//

import Foundation

// MARK: - NetworkRequest

protocol NetworkRequest {
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem] { get }
    var headers: [String: String] { get }
    var body: [String: Any]? { get }
}

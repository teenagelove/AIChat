//
//  Template2VideoRequest.swift
//  AIChat
//
//  Created by Danil Kazakov on 22.06.2026.
//

import ApphudSDK
import Foundation

// MARK: - Template2VideoRequest

struct Template2VideoRequest {
    let templateId: Int
    let imageData: Data
    let fileName: String
    let prompt: String?
    let duration: Int?
    let quality: String?

    func buildMultipartRequest() throws -> URLRequest {
        var components = URLComponents(string: "\(Constants.Dola.baseURL)\(Constants.PixVerse.basePath)/api/v1/template2video")!
        components.queryItems = baseQueryItems

        var request = URLRequest(url: components.url!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("Bearer \(Constants.Dola.bearerToken)", forHTTPHeaderField: "Authorization")

        let boundary = "Boundary.\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var body = Data()

        body.appendFormField(named: "template_id", value: "\(templateId)", boundary: boundary)

        if let prompt {
            body.appendFormField(named: "prompt", value: prompt, boundary: boundary)
        }

        if let duration {
            body.appendFormField(named: "duration", value: "\(duration)", boundary: boundary)
        }

        if let quality {
            body.appendFormField(named: "quality", value: quality, boundary: boundary)
        }

        body.appendFileField(named: "image", fileName: fileName, fileData: imageData, mimeType: "image/jpeg", boundary: boundary)
        body.append(Data("--\(boundary)--\r\n".utf8))

        request.httpBody = body
        return request
    }

    private var baseQueryItems: [URLQueryItem] {
        [
            URLQueryItem(name: "user_id", value: Apphud.userID()),
            URLQueryItem(name: "app_id", value: Constants.Dola.appId)
        ]
    }
}

// MARK: - Data Extension

private extension Data {

    mutating func appendFormField(named name: String, value: String, boundary: String) {
        append(Data("--\(boundary)\r\n".utf8))
        append(Data("Content-Disposition: form-data; name=\"\(name)\"\r\n\r\n".utf8))
        append(Data("\(value)\r\n".utf8))
    }

    mutating func appendFileField(named name: String, fileName: String, fileData: Data, mimeType: String, boundary: String) {
        append(Data("--\(boundary)\r\n".utf8))
        append(Data("Content-Disposition: form-data; name=\"\(name)\"; filename=\"\(fileName)\"\r\n".utf8))
        append(Data("Content-Type: \(mimeType)\r\n\r\n".utf8))
        append(fileData)
        append(Data("\r\n".utf8))
    }
}

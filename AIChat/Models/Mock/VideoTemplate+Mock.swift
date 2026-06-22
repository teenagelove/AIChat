//
//  VideoTemplate+Mock.swift
//  AIChat
//
//  Created by Danil Kazakov on 20.06.2026.
//

// MARK: - VideoTemplate Mock

extension VideoTemplate {
    static let mock: [VideoTemplate] = [
        VideoTemplate(
            id: 1, templateId: 1, name: "Pumpkin Magic",
            category: "\u{1F4C8} Trending", qualities: ["360p", "540p", "720p", "1080p"],
            duration: 5, previewSmall: "", previewLarge: ""
        ),
        VideoTemplate(
            id: 2, templateId: 2, name: "Ninja Shadow Clone",
            category: "\u{1F4C8} Trending", qualities: ["360p", "540p", "720p", "1080p"],
            duration: 5, previewSmall: "", previewLarge: ""
        ),
        VideoTemplate(
            id: 3, templateId: 3, name: "Vintage Photo Restoration",
            category: "\u{1F4C8} Trending", qualities: ["360p", "540p", "720p", "1080p"],
            duration: 5, previewSmall: "", previewLarge: ""
        ),
        VideoTemplate(
            id: 4, templateId: 4, name: "White Shark",
            category: "\u{1F3AC} Film & TV Inspo", qualities: ["360p", "540p", "720p", "1080p"],
            duration: 5, previewSmall: "", previewLarge: ""
        ),
        VideoTemplate(
            id: 5, templateId: 5, name: "Truck Fashion Shoot",
            category: "\u{2728} Ad Magic", qualities: ["360p", "540p", "720p", "1080p"],
            duration: 5, previewSmall: "", previewLarge: ""
        ),
        VideoTemplate(
            id: 6, templateId: 6, name: "Animal World",
            category: "\u{1F338} Spring Splendor", qualities: ["360p", "540p"],
            duration: 5, previewSmall: "", previewLarge: ""
        ),
        VideoTemplate(
            id: 7, templateId: 7, name: "Snow Dance",
            category: "\u{2744}\u{FE0F} Winter Vibe", qualities: ["360p", "540p", "720p", "1080p"],
            duration: 5, previewSmall: "", previewLarge: ""
        ),
        VideoTemplate(
            id: 8, templateId: 8, name: "Viral Challenge",
            category: "\u{1F525} Social Viral Hits", qualities: ["360p", "540p", "720p"],
            duration: 8, previewSmall: "", previewLarge: ""
        ),
        VideoTemplate(
            id: 9, templateId: 9, name: "Party Popper",
            category: "\u{1F389} Party Tricks", qualities: ["360p", "540p"],
            duration: 5, previewSmall: "", previewLarge: ""
        ),
        VideoTemplate(
            id: 10, templateId: 10, name: "Makeover Magic",
            category: "\u{1F484} Makeover Studio", qualities: ["360p", "540p", "720p", "1080p"],
            duration: 5, previewSmall: "", previewLarge: ""
        )
    ]
}

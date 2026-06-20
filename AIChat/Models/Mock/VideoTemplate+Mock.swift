//
//  VideoTemplate+Mock.swift
//  AIChat
//
//  Created by Danil Kazakov on 20.06.2026.
//

// MARK: - VideoTemplate Mock

extension VideoTemplate {
    static let mock: [VideoTemplate] = [
        VideoTemplate(title: "Cyberpunk City", image: .imageMock, category: .popular),
        VideoTemplate(title: "Neon Dreams", image: .imageMock, category: .popular),
        VideoTemplate(title: "Future Robot", image: .imageMock, category: .popular),
        VideoTemplate(title: "Funny Cat", image: .imageMock, category: .funny),
        VideoTemplate(title: "Dancing Dog", image: .imageMock, category: .funny),
        VideoTemplate(title: "Ocean Waves", image: .imageMock, category: .sad),
        VideoTemplate(title: "Rainy Day", image: .imageMock, category: .sad),
        VideoTemplate(title: "Viral Dance", image: .imageMock, category: .trends),
        VideoTemplate(title: "Epic Battle", image: .imageMock, category: .drama),
        VideoTemplate(title: "Space Journey", image: .imageMock, category: .drama),
        VideoTemplate(title: "Sunset Kiss", image: .imageMock, category: .romance),
        VideoTemplate(title: "Love Letter", image: .imageMock, category: .romance),
        VideoTemplate(title: "Haunted House", image: .imageMock, category: .horror),
        VideoTemplate(title: "Dark Forest", image: .imageMock, category: .horror)
    ]
}

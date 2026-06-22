//
//  AIChatApp.swift
//  AIChat
//
//  Created by Danil Kazakov on 18.06.2026.
//

import SwiftUI

// MARK: - AIChatApp

@main
struct AIChatApp: App {

    // MARK: - State

    @StateObject private var coordinator = Coordinator()
    @StateObject private var subscriptionService: SubscriptionService
    @StateObject private var paywallViewModel: PaywallViewModel
    private let chatService = ChatService()
    private let videoService = VideoGenerationService()

    // MARK: - Init

    init() {
        let service = SubscriptionService()
        _subscriptionService = StateObject(wrappedValue: service)
        _paywallViewModel = StateObject(wrappedValue: PaywallViewModel(subscriptionService: service))
        service.start()
    }

    // MARK: - Body

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $coordinator.path) {
                Group {
                    if subscriptionService.isSubscriptionChecked {
                        if subscriptionService.hasPremiumAccess {
                            MainView()
                        } else {
                            PaywallView()
                        }
                    } else {
                        ProgressView()
                    }
                }
                .navigationDestination(for: Screen.self) { screen in
                    destination(for: screen)
                }
            }
            .environmentObject(coordinator)
            .environmentObject(subscriptionService)
            .environmentObject(paywallViewModel)
            .preferredColorScheme(.dark)
        }
    }

    // MARK: - Private

    @ViewBuilder
    private func destination(for screen: Screen) -> some View {
        switch screen {
        case .main:
            MainView()
        case .paywall:
            PaywallView()
        case .chat:
            ChatView(chatService: chatService)
        case .chatList:
            ChatListView(chatService: chatService)
        case .videoTemplates:
            VideoTemplatesView(videoService: videoService)
        case .videoGenerate(let template):
            VideoGenerateView(template: template, videoService: videoService)
        case .resultVideoGen:
            ResultVideoGenView(
                viewModel: VideoGenerateViewModel(
                    template: VideoTemplate.mock[0],
                    allTemplates: VideoTemplate.mock,
                    videoService: videoService
                )
            )
        }
    }
}

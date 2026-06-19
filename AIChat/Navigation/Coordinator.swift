//
//  Coordinator.swift
//  AIChat
//
//  Created by Danil Kazakov on 19.06.2026.
//

import Combine
import SwiftUI

// MARK: - Coordinator

final class Coordinator: ObservableObject {

    // MARK: - Published

    @Published var path = NavigationPath()

    // MARK: - Navigation

    func navigate(to screen: Screen) {
        path.append(screen)
    }

    func goBack() {
        path.removeLast()
    }

    func popToRoot() {
        path = NavigationPath()
    }
}

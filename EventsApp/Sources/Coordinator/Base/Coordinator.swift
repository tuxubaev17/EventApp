//
//  Coordinator.swift
//  EventsApp
//
//  Created by Alikhan on 24.05.2022.
//

import Foundation

protocol Coordinator {
    var childCoordinators: [Coordinator] { get }
    func start()
    func coordinate(to coordinator: Coordinator)
}

extension Coordinator {
    func coordinate(to coordinator: Coordinator) {
        coordinator.start()
    }
}

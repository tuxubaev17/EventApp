//
//  Coordinator.swift
//  EventsApp
//
//  Created by Alikhan on 24.05.2022.
//

import Foundation

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get }
    func start()
    func coordinate(to coordinator: Coordinator)
    func childDidFinish(_ childCoordinator: Coordinator) 
}

extension Coordinator {
    func coordinate(to coordinator: Coordinator) {
        coordinator.start()
    }
    
    func childDidFinish(_ childCoordinator: Coordinator) {}
}

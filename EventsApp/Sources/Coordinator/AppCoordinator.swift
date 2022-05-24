//
//  AppCoordinator.swift
//  EventsApp
//
//  Created by Alikhan on 24.05.2022.
//

import Foundation
import UIKit

final class AppCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        let startCoordinator = EventListCoordinator(navigationContoller: navigationController)
        childCoordinators.append(startCoordinator)
        coordinate(to: startCoordinator)
    }
}


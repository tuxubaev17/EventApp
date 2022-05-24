//
//  EventListCoordinator.swift
//  EventsApp
//
//  Created by Alikhan on 24.05.2022.
//

import Foundation
import UIKit

final class EventListCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    private let navigationContoller: UINavigationController
    
    init(navigationContoller: UINavigationController) {
        self.navigationContoller = navigationContoller
    }
    func start() {
        let eventListViewController = EventListViewController()
        navigationContoller.pushViewController(eventListViewController, animated: true)
    }
}
 

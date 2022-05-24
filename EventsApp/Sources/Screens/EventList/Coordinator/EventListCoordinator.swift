//
//  EventListCoordinator.swift
//  EventsApp
//
//  Created by Alikhan on 24.05.2022.
//

import Foundation
import UIKit

final class EventListCoordinator: Coordinator {
    private (set) var childCoordinators: [Coordinator] = []
    
    private let navigationContoller: UINavigationController
    
    init(navigationContoller: UINavigationController) {
        self.navigationContoller = navigationContoller
    }
    
    func start() {
        let eventListViewController = EventListViewController()
        let evenListViewModel = EventListViewModel()
        evenListViewModel.coordinator = self
        eventListViewController.viewModel = evenListViewModel
        navigationContoller.pushViewController(eventListViewController, animated: true)
        navigationContoller.navigationBar.prefersLargeTitles = true
    }
 
    func startAddEvent() {
        let addEventListCoordinator = AddEventCoordinator(navigationController: navigationContoller)
        childCoordinators.append(addEventListCoordinator)
        coordinate(to: addEventListCoordinator)
    }
    
    func childDidFinish(_ childCoordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { (coordinator) -> Bool in
            return childCoordinator === coordinator
        }) {
            childCoordinators.remove(at: index)
        }
    }
}
 

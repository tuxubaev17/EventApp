//
//  EventListCoordinator.swift
//  EventsApp
//
//  Created by Alikhan on 24.05.2022.
//

import Foundation
import UIKit
import CoreData

final class EventListCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    var onSaveEvent = {}
    private let navigationContoller: UINavigationController
    
    init(navigationContoller: UINavigationController) {
        self.navigationContoller = navigationContoller
    }
    
    func start() {
        let eventListViewController = EventListViewController()
        let evenListViewModel = EventListViewModel()
        evenListViewModel.coordinator = self
        onSaveEvent = evenListViewModel.reload
        eventListViewController.viewModel = evenListViewModel
        navigationContoller.pushViewController(eventListViewController, animated: true)
    }
 
    func startAddEvent() {
        let addEventListCoordinator = AddEventCoordinator(navigationController: navigationContoller)
        addEventListCoordinator.parentCoordinator = self
        childCoordinators.append(addEventListCoordinator)
        coordinate(to: addEventListCoordinator)
    }
    
    func onSelect(_ id: NSManagedObjectID) {
        let eventDetailCoordinator = EventDetailCoordinator(navigationController: navigationContoller, eventID: id)
        eventDetailCoordinator.parentCoordinator = self
        childCoordinators.append(eventDetailCoordinator)
        coordinate(to: eventDetailCoordinator)
    }
    
    func childDidFinish(_ childCoordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { coordinator -> Bool in
            return childCoordinator === coordinator
        }) {
            childCoordinators.remove(at: index)
        }
    }
}
 

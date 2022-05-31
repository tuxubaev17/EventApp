//
//  EventDetailCoordinator.swift
//  EventsApp
//
//  Created by Alikhan on 30.05.2022.
//

import UIKit
import CoreData

class EventDetailCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    private let eventID: NSManagedObjectID
    var parentCoordinator: EventListCoordinator?
    
    init(navigationController: UINavigationController, eventID: NSManagedObjectID) {
        self.navigationController = navigationController
        self.eventID = eventID
    }
    
    func start() {
        let eventDetailViewController = EventDetailViewController()
        let eventDetailViewModel = EventDetailViewModel(eventId: eventID)
        eventDetailViewModel.coordinator = self
        eventDetailViewController.viewModel = eventDetailViewModel
        navigationController.pushViewController(eventDetailViewController, animated: true )
    }
    
    func didFinish() {
        parentCoordinator?.childDidFinish(self)
    }
}

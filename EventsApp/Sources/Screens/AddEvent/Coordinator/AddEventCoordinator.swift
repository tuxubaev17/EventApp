//
//  AddEventCoordinator.swift
//  EventsApp
//
//  Created by Alikhan on 24.05.2022.
//

import Foundation
import UIKit

final class AddEventCoordinator: Coordinator {
    private (set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    
    var parentCoordinator: EventListCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let addEventViewController = AddEventViewController()
        let addEventViewModel = AddEventViewModel()
        addEventViewModel.coordinator = self
        addEventViewController.viewModel = addEventViewModel
        navigationController.present(addEventViewController, animated: true, completion: nil)
    }
    
    func didFinishAddEvent() {
        parentCoordinator?.childDidFinish(self)
    }
}

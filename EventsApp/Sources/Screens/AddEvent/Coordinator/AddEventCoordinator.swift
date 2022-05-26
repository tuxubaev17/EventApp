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
    private var modalNavigationController: UINavigationController?
    private var completion: Callback<UIImage>?
    var parentCoordinator: EventListCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        self.modalNavigationController = UINavigationController()
        let addEventViewController = AddEventViewController()
        modalNavigationController?.setViewControllers([addEventViewController], animated: true)
        let addEventViewModel = AddEventViewModel(cellBuider: EventsCellBuilder(), coreDataManager: CoreDataManager())
        addEventViewModel.coordinator = self
        addEventViewController.viewModel = addEventViewModel
        if let modalNavigationController = modalNavigationController {
            navigationController.present(modalNavigationController, animated: true, completion: nil)
        }
    }
    
    func didFinish() {
        parentCoordinator?.childDidFinish(self)
    }
    
    func didFinishSaveEvent() {
        navigationController.dismiss(animated: true, completion: nil)
    }
    
    func showImagePicker(completion: @escaping Callback<UIImage>) {
        guard let modalNavigationController = modalNavigationController else { return }
        self.completion = completion
        let imagePickerCoordinator =  ImagePickerCoordinator(navigationController: modalNavigationController)
        imagePickerCoordinator.parentCoordinator = self
        childCoordinators.append(imagePickerCoordinator)
        coordinate(to: imagePickerCoordinator)
    }
    
    func didFinishPicking(_ image: UIImage) {
        completion?(image)
        modalNavigationController?.dismiss(animated: true, completion: nil)
    }
    
    func childDidFinish(_ childCoordinator: Coordinator) {
        print(CoreDataManager().fetchEvents().first?.name)

        if let index = childCoordinators.firstIndex(where: { coordinator -> Bool in
            return childCoordinator === coordinator
        }) {
            childCoordinators.remove(at: index)
        }
    }
}

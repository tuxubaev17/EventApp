//
//  ImagePickerCoordinator.swift
//  EventsApp
//
//  Created by Alikhan on 26.05.2022.
//

import Foundation
import UIKit

final class ImagePickerCoordinator: NSObject ,Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    var parentCoordinator: Coordinator?
    var onFinishPicking: Callback<UIImage>?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let imagePickerViewController = UIImagePickerController()
        imagePickerViewController.delegate = self
        navigationController.present(imagePickerViewController, animated: true, completion: nil)
    }
}

extension ImagePickerCoordinator: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            onFinishPicking?(image) 
        }
        parentCoordinator?.childDidFinish(self)
    }
}

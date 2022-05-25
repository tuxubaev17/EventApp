//
//  AddEventViewModel.swift
//  EventsApp
//
//  Created by Alikhan on 24.05.2022.
//

import Foundation

final class AddEventViewModel {
    var coordinator: AddEventCoordinator?
    
    func viewDidDisappear() {
        coordinator?.didFinishAddEvent()
    }
}

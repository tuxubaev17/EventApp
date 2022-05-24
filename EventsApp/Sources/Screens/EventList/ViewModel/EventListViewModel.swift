//
//  EventListViewModel.swift
//  EventsApp
//
//  Created by Alikhan on 24.05.2022.
//

import Foundation

final class EventListViewModel {
    
    let title = "Events"
    var coordinator: EventListCoordinator?
    
    func tappedAddEvent() {
        coordinator?.startAddEvent()
    }
}

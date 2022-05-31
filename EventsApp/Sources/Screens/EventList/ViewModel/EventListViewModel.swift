//
//  EventListViewModel.swift
//  EventsApp
//
//  Created by Alikhan on 24.05.2022.
//

import Foundation

final class EventListViewModel {
    
    enum Cell {
        case event(EventCellViewModel)
    }
    
    var onUpdate: VoidCallback?
    
    private(set) var cells: [Cell] = []
    
    var coordinator: EventListCoordinator?
    private let corDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager = CoreDataManager.shared) {
        self.corDataManager = coreDataManager
    }
    
    func reload() {
        updateCell()
    }
    
    func tappedAddEvent() {
        coordinator?.startAddEvent()
    }
    
    func numberOfRows() -> Int {
        return cells.count
    }
    
    func cell(at indexPath: IndexPath) -> Cell {
        return cells[indexPath.row]
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        switch cells[indexPath.row] {
        case .event(let eventCellViewModel):
            eventCellViewModel.didSelect()
        }
    }
}

extension EventListViewModel {
    func updateCell() {
        let events = corDataManager.fetchEvents()
        cells = events.map {
            var eventCellViewModel = EventCellViewModel($0)
            if let coordinator = coordinator {
                eventCellViewModel.onSelect =  coordinator.onSelect
            }
            return .event(eventCellViewModel)
        }
        onUpdate?()
    }
}

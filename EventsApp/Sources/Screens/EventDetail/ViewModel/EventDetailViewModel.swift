//
//  EventDetailViewModel.swift
//  EventsApp
//
//  Created by Alikhan on 30.05.2022.
//

import CoreData
import UIKit

final class EventDetailViewModel {
    
    private let eventId: NSManagedObjectID
    private let coreDataManager: CoreDataManager
    private var event: Event?
    private let date = Date()
    var coordinator: EventDetailCoordinator?
    var onUpdate: VoidCallback?
    
    var image: UIImage? {
        guard let image = event?.image else { return nil }
        return UIImage(data: image)
    }
    
    var timeRemainingViewModel: TimeRemainingViewModel? {
        guard let eventDate = event?.date, let timeRemainingParts = date.timeRemaining(until: eventDate)?.components(separatedBy: ",") else { return nil }
        return TimeRemainingViewModel(timeRemainingParts: timeRemainingParts, mode: .detail)
    }
    
    init(eventId: NSManagedObjectID, coreDataManager: CoreDataManager = CoreDataManager.shared) {
        self.eventId = eventId
        self.coreDataManager = coreDataManager
    }
    
    func viewDidLoad() {
        event = coreDataManager.getEvent(eventId)
        onUpdate?()
    }
    
    func viewDidDisappear() {
        coordinator?.didFinish()
        
    }
}

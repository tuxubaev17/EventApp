//
//  CoreDataManager.swift
//  EventsApp
//
//  Created by Alikhan on 24.05.2022.
//

import CoreData
import UIKit

final class CoreDataManager {
    static let shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: "EventsApp")
        persistentContainer.loadPersistentStores { (_, error) in
            print(error?.localizedDescription ?? "")
        }
        return persistentContainer
    }()
    
    var moc: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    func saveEvent(name: String, date: Date, image: UIImage) {
        let event = Event(context: moc)
        event.setValue(name, forKey: "name")
        
        let resizedImage = image.sameAspectRatio(newHeight: 250)
        let imageData = image.jpegData(compressionQuality: 0.5)
        event.setValue(imageData, forKey: "image")
        event.setValue(date, forKey: "date")
        
        do {
            try moc.save()
        } catch {
            print(error)
        }
    }
    
    func fetchEvents() -> [Event] {
        do {
            let featchRequest = NSFetchRequest<Event>(entityName: "Event")
            let events = try moc.fetch(featchRequest)
            return events
        } catch {
            print(error)
            return []
        }
    }
    
    func getEvent(_ id: NSManagedObjectID) -> Event? {
        do {
            return try moc.existingObject(with: id) as? Event
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}


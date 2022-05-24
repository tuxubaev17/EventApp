//
//  CoreDataManager.swift
//  EventsApp
//
//  Created by Alikhan on 24.05.2022.
//

import CoreData
import UIKit

final class CoreDataManager {
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
        let imageData = image.jpegData(compressionQuality: 1)
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
}


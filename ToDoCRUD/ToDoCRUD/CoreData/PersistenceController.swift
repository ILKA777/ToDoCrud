//
//  Persistance.swift
//  ToDoCRUD
//
//  Created by Илья on 04.02.2024.
//

import SwiftUI
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for index in 0 ..< 10 {
            
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        let taskEntity = NSEntityDescription()
        taskEntity.name = "Task"
        taskEntity.managedObjectClassName = "Task"
        
        let idAttribute = NSAttributeDescription()
        idAttribute.name = "id"
        idAttribute.type = .uuid
        taskEntity.properties.append(idAttribute)
        
        let nameAttribute = NSAttributeDescription()
        nameAttribute.name = "name"
        nameAttribute.type = .string
        taskEntity.properties.append(nameAttribute)
        
        let completeAttribute = NSAttributeDescription()
        completeAttribute.name = "complete"
        completeAttribute.type = .boolean
        taskEntity.properties.append(completeAttribute)
        
        let priorityNumAttribute = NSAttributeDescription()
        priorityNumAttribute.name = "priorityNum"
        priorityNumAttribute.type = .integer32
        taskEntity.properties.append(priorityNumAttribute)
        
        let dueDateAttribute = NSAttributeDescription()
        dueDateAttribute.name = "dueDate"
        dueDateAttribute.type = .date
        taskEntity.properties.append(dueDateAttribute)
        
        let model = NSManagedObjectModel()
        model.entities = [taskEntity]
        
        container = NSPersistentContainer(name: "TaskToDo", managedObjectModel: model)
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}

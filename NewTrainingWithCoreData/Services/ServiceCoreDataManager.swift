//
//  ServiceCoreDataManager.swift
//  NewTrainingWithCoreData
//
//  Created by Guillaume Donzeau on 13/08/2021.
//

import Foundation
import UIKit
import CoreData

class EntityCoreDataManager {
    private let viewContext: NSManagedObjectContext
    static let shared = EntityCoreDataManager()
    init(persistentContainer: NSPersistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer) {
        self.viewContext = persistentContainer.viewContext
    }
    
    static var all:[EntityTest] {
        let request: NSFetchRequest<EntityTest> = EntityTest.fetchRequest()
        guard let entities = try? AppDelegate.viewContext.fetch(request) else {
            return []
        }
        return entities
    }
    
    func loadEntities() -> [EntityUsable] {
        let request: NSFetchRequest<EntityTest> = EntityTest.fetchRequest()
        var entitiesUsable = [EntityUsable]()
        guard let entitiesReceived = try? AppDelegate.viewContext.fetch(request) else {
            return []
        }
        for object in entitiesReceived {
            if let name = object.name {
                let newEntity = EntityUsable(name: name, invited: object.invited)
                entitiesUsable.append(newEntity)
            }
        }
        return entitiesUsable
    }
    
    func newSaveEntity(name: String, invited: Float) {
        let entityToSave = EntityTest(context: AppDelegate.viewContext)
        entityToSave.name = name
        entityToSave.invited = invited
        try? AppDelegate.viewContext.save()
    }
    
    func deleteEntity(entityToDelete: EntityUsable) {
        let request: NSFetchRequest<EntityTest> = EntityTest.fetchRequest()
        let entityToDeleteConverted = convertFromUsableToCoreData(entityToConvert: entityToDelete)
        do {
            let response = try viewContext.fetch(request)
            for recipe in response {
                if recipe.name == entityToDeleteConverted.name && recipe.invited == entityToDeleteConverted.invited {
                viewContext.delete(recipe)
                }
            }
        } catch {
            print("Error while deleting")
            return
        }
        AppDelegate.viewContext.delete(entityToDeleteConverted)
        try? viewContext.save()
    }
    
    func deleteAll() {
        let request: NSFetchRequest<EntityTest> = EntityTest.fetchRequest()
        do {
            let response = try viewContext.fetch(request)
            
            for recipe in response {
                viewContext.delete(recipe)
            }
            try? viewContext.save()
            
        } catch {
            print("Error while deleting")
            return
        }
    }
    
    private func convertFromUsableToCoreData(entityToConvert: EntityUsable) -> EntityTest {
        let entityConverted = EntityTest(context: AppDelegate.viewContext)
        let name = entityToConvert.name
        
        entityConverted.name = name
        entityConverted.invited = entityToConvert.invited
        return entityConverted
    }
    
}


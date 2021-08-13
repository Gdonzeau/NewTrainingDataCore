//
//  ViewController.swift
//  NewTrainingWithCoreData
//
//  Created by Guillaume Donzeau on 13/08/2021.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    // Pour le test
    //let recipeCoreDataManager = RecipeCoreDataManager()
    var entitiesPresent = [EntityTest]()
    // fin du test

    override func viewDidLoad() {
        super.viewDidLoad()
        // Test
        /*
         On charge le nombre d'entitiesTest en mémoire.
         On affiche leur nombre. S'il est supérieur à zéro, on affiche les données (nom et nombre de personnes)
         On crée une nouvelle EntityTest avec pour nom "Name"+ un nombre aléatoire
         et pour nombre de personnes le nombre d'EntitiesTest déjà enregistrées.
         */
        // On charge les entités
        var entitiesLoaded = loadEntities()
        print("Nous avons \(entitiesLoaded.count) entités chargées.")
        entitiesLoaded = []
        print("Nous avons à présent \(entitiesLoaded.count) entités chargées.")
        // Puis on crée une nouvelle entité...
        let entityCreated = createEntity() // D'où viennent les optionels ?
        print("Nous avons créé l'entité \(String(describing: entityCreated.name)) avec \(entityCreated.invited).")
        // Nous la convertissons
        let entityUsable = convertCoreDataEntityToUsableEntity(entityToConvert: entityCreated)
        print("Nous avons l'entité Usable \(entityUsable.name) avec \(entityUsable.invited)")
        // ... que l'on convertit (même si elle l'est déjà sous le nom de entityCreated)
        //let entityToSave = convertUsableEntityToCoreDataEntity(entityToConvert: entityUsable)
        saveEntity(entityToSave: entityUsable)
        // Fin du Test
        
    }
    // Méthodes pour les tests
    private func convertUsableEntityToCoreDataEntity(entityToConvert:EntityUsable) -> EntityTest {
        let entityCoreData = EntityTest(context: AppDelegate.viewContext)
        entityCoreData.name = entityToConvert.name
        entityCoreData.invited = entityToConvert.invited
        return entityCoreData
    }
    private func convertCoreDataEntityToUsableEntity(entityToConvert:EntityTest) -> EntityUsable {
        if let name = entityToConvert.name {
        let entityUsable = EntityUsable(name: name, invited: entityToConvert.invited)
            return entityUsable
        }
        return EntityUsable(name: "", invited: 0.00) // En cas d'échec on revoie une entité nulle.
    }
    private func loadEntities() -> [EntityTest] {
        let request: NSFetchRequest<EntityTest> = EntityTest.fetchRequest()
        var entitiesTest = [EntityTest]()
        if let entitiesReceived = try? AppDelegate.viewContext.fetch(request) {
            print("Le tableau contient \(entitiesReceived.count) entité(s)")
            for object in entitiesReceived {
                let newEntity = EntityTest(context: AppDelegate.viewContext)
                newEntity.name = object.name
                newEntity.invited = object.invited
                entitiesTest.append(newEntity)
            }
        }
            print("Il y a actuellement \(entitiesTest.count) entités déjà enregistrée(s)")
            
            if entitiesTest.count > 0 {
                entitiesPresent = [] // On remet à zéro
                for object in entitiesTest {
                    print("Entité \(String(describing: object.name)) avec \(object.invited) personnes")
                    entitiesPresent.append(object)
                    // On se retrouve avec un tableau d'entités.
                }
                print("Reste : \(entitiesTest.count)")
            }
        return entitiesTest
    }
    
    private func deleteEntity() {
        
    }
    private func saveEntity(entityToSave: EntityUsable) {
        let entityCoreData = EntityTest(context: AppDelegate.viewContext)
        entityCoreData.name = entityToSave.name
        entityCoreData.invited = entityToSave.invited
        try? AppDelegate.viewContext.save() // On essaie de svg
    }
    
    private func createEntity() -> EntityTest {
        let newEntity = EntityTest(context: AppDelegate.viewContext)
        let randomNumber = Int.random(in: 1 ... 100)
        newEntity.name = "Name" + String(randomNumber)
        newEntity.invited = Float.random(in: 1 ... 100)
        return newEntity
    }
    // Fin des méthodes pour les tests

}


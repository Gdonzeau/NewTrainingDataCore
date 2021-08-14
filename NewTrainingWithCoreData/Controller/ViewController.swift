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
    var entitiesSaved = [EntityUsable]()
    //var entityCreated = EntityTest(context: AppDelegate.viewContext)
    var entityCreated = EntityUsable(name: "", invited: 0.00)
    let entityCoreDataManager = EntityCoreDataManager()
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
        //let resultat = EntityCoreDataManager.all
        entitiesSaved = entityCoreDataManager.loadEntities()
        print("premier essai : nous avons \(entitiesSaved.count) résultats.")
        // On affiche le résultat
        for objet in entitiesSaved {
            print("L'entité \(String(describing: objet.name)) qui contient \(objet.invited).")
        }
        // Nous supprimons la première entité appelée
        print("Nous supprimons \(entitiesSaved[0].name)")
        entityCoreDataManager.deleteRecipe(entityToDelete: entitiesSaved[0])
        // Puis on crée une nouvelle entité...
        
        newCreateEntity()
        print("Nous avons créé l'entité \(String(describing: entityCreated.name)) avec \(entityCreated.invited).")
        
        entityCoreDataManager.newSaveEntity(name: entityCreated.name, invited: entityCreated.invited)
        // Fin du Test
        
    }
    // Méthodes pour les tests
    /*
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
    */
    
    private func deleteEntity() {
        
    }
    //private func saveEntity(entityToSave: EntityUsable) {
    private func saveEntity() {
        //entityCreated = EntityTest() // On vide l'entité de base avant d'appeler une sauvegarde
        /*
        let entityCoreData = EntityTest(context: AppDelegate.viewContext)
        entityCoreData.name = entityToSave.name
        entityCoreData.invited = entityToSave.invited
 */
        try? AppDelegate.viewContext.save() // On essaie de svg
    }
    /*
    private func createEntity() -> EntityTest {
        let newEntity = EntityTest(context: AppDelegate.viewContext)
        let randomNumber = Int.random(in: 1 ... 100)
        newEntity.name = "Name" + String(randomNumber)
        newEntity.invited = Float.random(in: 1 ... 100)
        return newEntity
    }*/
    private func newCreateEntity() {
        let randomNumber = Int.random(in: 1 ... 100)
        let name = "Name" + String(randomNumber)
        let invited = Float.random(in: 1 ... 100)
        entityCreated.name = name
        entityCreated.invited = invited
    }
    // Fin des méthodes pour les tests

}


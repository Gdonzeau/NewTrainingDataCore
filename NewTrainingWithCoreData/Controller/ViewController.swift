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
        entityCoreDataManager.deleteEntity(entityToDelete: entitiesSaved[0])
        // Puis on crée une nouvelle entité...
        
        newCreateEntity()
        print("Nous avons créé l'entité \(String(describing: entityCreated.name)) avec \(entityCreated.invited).")
        //... que l'on sauvegarde
        entityCoreDataManager.newSaveEntity(name: entityCreated.name, invited: entityCreated.invited)
        // Fin du Test
        
    }
    
    private func newCreateEntity() {
        let randomNumber = Int.random(in: 1 ... 100)
        let name = "Name" + String(randomNumber)
        let invited = Float.random(in: 1 ... 100)
        entityCreated.name = name
        entityCreated.invited = invited
    }
}


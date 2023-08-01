//
//  CoreDataFunctions.swift
//  Movie App
//
//  Created by oguzhan.deniz on 1.08.2023.
//

import Foundation
import UIKit
import CoreData

class CoreDataFunctions {
    
    static func saveMovie(movie: Results) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: CoreDataConstants.entityName, in: managedContext) else {
            return
        }
        let mov = NSManagedObject(entity: entity, insertInto: managedContext)
        
        mov.setValue(movie.id, forKey: CoreDataConstants.idKeyPath)
        mov.setValue(movie.title, forKey: CoreDataConstants.titleKeyPath)
        mov.setValue(movie.poster_path, forKey: CoreDataConstants.posterPathKeyPath)
        mov.setValue(movie.vote_average, forKey: CoreDataConstants.scoreKeyPath)
        mov.setValue(movie.release_date, forKey: CoreDataConstants.releaseDateKeyPath)
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    static func loadMovies() -> [NSManagedObject] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return []
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: CoreDataConstants.entityName)
        
        do {
            return try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }
    
    static func deleteMovie() {
        
    }
}

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
    
    static func saveMovie(id: Int, score: Double, title: String, poster_path: String, releaseDate: String) {
        
        let managedContext = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: CoreDataConstants.entityName, in: managedContext) else {
            return
        }
        let mov = NSManagedObject(entity: entity, insertInto: managedContext)
//        let mov = MovieEntity(context: managedContext)
        
        mov.setValue(id, forKey: CoreDataConstants.idKeyPath)
        mov.setValue(title, forKey: CoreDataConstants.titleKeyPath)
        mov.setValue(poster_path, forKey: CoreDataConstants.posterPathKeyPath)
        mov.setValue(score, forKey: CoreDataConstants.scoreKeyPath)
        mov.setValue(releaseDate, forKey: CoreDataConstants.releaseDateKeyPath)
        
        AppDelegate.sharedAppDelegate.coreDataStack.saveContext()
    }
    
    static func loadMovies() -> [NSManagedObject] {
        
        let movieFetch: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        
        do {
            let managedContext = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
            return try managedContext.fetch(movieFetch)
            
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
            return []
        }
    }
    
    static func deleteMovie(id: Int) {
        
        let managedContext = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
        
        let fetchRequest: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "id==\(id)")
        
        do {
            let objects = try managedContext.fetch(fetchRequest)
            for obj in objects {
                managedContext.delete(obj)
            }
            
            try managedContext.save()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    static func checkMovie(id: Int) -> Bool {
        
        let managedContext = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
        
        let fetchRequest: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "id==\(id)")
        
        do {
            let objects = try managedContext.fetch(fetchRequest)
            
            if objects.count > 0 {
                return true
            } else {
                return false
            }
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return true
        }
    }
}

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
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: CoreDataConstants.entityName, in: managedContext) else {
            return
        }
        let mov = NSManagedObject(entity: entity, insertInto: managedContext)
        
        mov.setValue(id, forKey: CoreDataConstants.idKeyPath)
        mov.setValue(title, forKey: CoreDataConstants.titleKeyPath)
        mov.setValue(poster_path, forKey: CoreDataConstants.posterPathKeyPath)
        mov.setValue(score, forKey: CoreDataConstants.scoreKeyPath)
        mov.setValue(releaseDate, forKey: CoreDataConstants.releaseDateKeyPath)
        
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
    
    static func deleteMovie(id: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSManagedObject.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "\(CoreDataConstants.idKeyPath)=\(id)")
        
        do {
            let objects = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            for obj in objects {
                managedContext.delete(obj)
            }
            
            try managedContext.save()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    static func checkMovie(id: Int) -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return true
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSManagedObject.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "\(CoreDataConstants.idKeyPath) == %@", id)
        
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

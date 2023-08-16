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
    static func saveMovie(movie: Movie) {
        
        let managedContext = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
        
        let mov = MovieEntity(context: managedContext)
        
        mov.id = Int64(movie.id ?? 0)
        mov.title = movie.title ?? ""
        mov.posterPath = movie.posterPath ?? ""
        mov.score = movie.voteAverage ?? 0.0
        mov.releaseDate = movie.releaseDate ?? ""
        
        AppDelegate.sharedAppDelegate.coreDataStack.saveContext()
    }
    
    static func loadMovies() -> [Movie] {
        
        let movieFetch: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        
        do {
            let managedContext = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
            let movieEntities = try managedContext.fetch(movieFetch)
            return movieEntities.map { Movie.init(movieEntity: $0) }
            
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

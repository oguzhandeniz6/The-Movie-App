//
//  MovieEntity+CoreDataProperties.swift
//  Movie App
//
//  Created by oguzhan.deniz on 2.08.2023.
//
//

import Foundation
import CoreData


extension MovieEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieEntity> {
        return NSFetchRequest<MovieEntity>(entityName: "MovieEntity")
    }

    @NSManaged public var id: Int64
    @NSManaged public var posterPath: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var score: Double
    @NSManaged public var title: String?

}

extension MovieEntity : Identifiable {

}

//
//  Actor.swift
//  Movie App
//
//  Created by oguzhan.deniz on 28.07.2023.
//

import Foundation

struct Actor : Codable {
    let id: Int?
    let name: String?
    let birthday: String?
    let deathday: String?
    let place_of_birth: String?
    let biography: String?
    let profile_path: String?
}

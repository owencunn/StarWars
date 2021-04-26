//
//  Character.swift
//  StarWars
//
//  Created by Owen Cunningham on 2021/03/25.
//

import Foundation

struct People: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Result]
}

struct Result: Codable {
    let name: String
    let birth_year: String
    let eye_color: String
    let gender: String
    let hair_color: String
    let height: String
    let mass: String
    let skin_color: String
    let homeworld: String
    let films: [String]
    let species: [String]
    let starships: [String]
    let vehicles: [String]
    let url: String
    let created: String
    let edited: String
}

struct Planet: Codable {
    let name: String
    let diameter: String
    let rotation_period: String
    let orbital_period: String
    let gravity: String
    let population: String
    let climate: String
    let terrain: String
    let surface_water: String
    let residents: [String]
    let films: [String]
    let url: String
    let created: String
    let edited: String
}

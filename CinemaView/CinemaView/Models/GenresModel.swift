//
//  GenresModel.swift
//  CinemaView
//
//  Created by Monica Galan de la Llana on 17/1/22.
//

import Foundation

// MARK: - Welcome
struct GenresModel: Codable {
    let genres: [Genre]?

    enum CodingKeys: String, CodingKey {
        case genres = "genres"
    }
}

// MARK: - Genre
struct Genre: Codable, Identifiable {
    let id: Int?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}

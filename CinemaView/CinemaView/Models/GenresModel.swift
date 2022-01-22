//
//  GenresModel.swift
//  CinemaView
//
//  Created by Monica Galan de la Llana on 17/1/22.
//

import Foundation

// MARK: - GenresModel
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


extension Bundle {
    
    func loadAndDecodeJSON<D: Decodable>(filename: String) throws -> D? {
        guard let url = self.url(forResource: filename, withExtension: "json") else {
            return nil
        }
        let data = try Data(contentsOf: url)
        let decodeModel = try JSONDecoder().decode(D.self, from: data)
        return decodeModel
    }
}

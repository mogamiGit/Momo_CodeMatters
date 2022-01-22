//
//  DetailGenreFilterModel.swift
//  CinemaView
//
//  Created by Monica Galan de la Llana on 19/1/22.
//

import Foundation

// MARK: - DetailGenreFilterModel
struct DetailGenreFilterModel: Codable {
    let page: Int?
    let results: [ResultFilterGenre]?
    let totalPages: Int?
    let totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page = "page"
        case results = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct ResultFilterGenre: Codable, Identifiable {
    let adult: Bool?
    let backdropPath: String?
    let genreids: [Int]?
    let id: Int?
    let originalLanguage: String?
    let originalTitle: String?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult = "adult"
        case backdropPath = "backdrop_path"
        case genreids = "genre_ids"
        case id = "id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview = "overview"
        case popularity = "popularity"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title = "title"
        case video = "video"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    var posterUrl: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath ?? "")")!
    }
    
    var backdropUrl : URL {
        return URL(string: "https://image.tmdb.org/t/p/w500/\(backdropPath ?? "")")!
    }
}

extension DetailGenreFilterModel {
    
    static var stubbedDetailMovieModel: DetailGenreFilterModel {
        let response: DetailGenreFilterModel? = try? Bundle.main.loadAndDecodeJSON(filename: "FilterByGenre")
        return response!
    }
    
}

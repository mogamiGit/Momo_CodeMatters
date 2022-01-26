//
//  NewMoviesModel.swift
//  CinemaView
//
//  Created by Monica Galan de la Llana on 20/1/22.
//

import Foundation

struct NewMoviesModel: Identifiable {
    
    let id: Int?
    let backdropPath: String?
    let posterPath: String?
    let name: String?
    
    var posterUrl: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath ?? "")")!
    }
    
    var backdropUrl : URL {
        return URL(string: "https://image.tmdb.org/t/p/w500/\(backdropPath ?? "")")!
    }
}

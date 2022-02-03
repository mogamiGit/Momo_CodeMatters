//
//  SaveFavourites.swift
//  CinemaView
//
//  Created by Monica Galan de la Llana on 3/2/22.
//

import Foundation

class SaveFavourites: ObservableObject {
    
    private var movie: Set<Int>
    private let saveKey = "Favorites"
    
    init() {
        // load our saved data
        
        // still here? Use an empty array
        movie = []
    }
    
    // returns true if our set contains this resort
    func contains(_ movies: DetailMovieModel) -> Bool {
        movie.contains(movies.id ?? 0)
    }
    
    // adds the resort to our set, updates all views, and saves the change
    func add(_ movies: DetailMovieModel) {
        objectWillChange.send()
        movie.insert(movies.id ?? 0)
        save()
    }
    
    // removes the resort from our set, updates all views, and saves the change
    func remove(_ movies: DetailMovieModel) {
        objectWillChange.send()
        movie.remove(movies.id ?? 0)
        save()
    }
    
    func save() {
        // write out our data
    }
}

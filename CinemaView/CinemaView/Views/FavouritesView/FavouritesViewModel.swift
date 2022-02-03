//
// Created on 3/2/22.
// subfolder/FavouritesViewModel.swift - Very brief description
//

import Foundation
import FirebaseFirestore

// MARK: - Output -> Interactor
protocol FavouritesInteractorOutputProtocol: BaseInteractorOutputProtocol {
    
}

final class FavouritesViewModel: BaseViewModel, ObservableObject {
    
    @Published var arrayMoviesFav : [NewMoviesModel] = []
    private var dbFirebase = Firestore.firestore()
    
    // MARK: VIP Dependencies
    var interactor: FavouritesInteractorInputProtocol? {
        super.baseInteractor as? FavouritesInteractorInputProtocol
    }
    
    func fetchData() {
        
        let userId = "m.galan"
        
        dbFirebase.collection("favourites").document("\(userId)").collection("movies").addSnapshotListener { (querySnapshot, error) in guard let documents = querySnapshot?.documents else {
            print("No documents")
            return
            }
            
            documents.forEach { document in
                self.arrayMoviesFav = documents.map { queryDocumentSnapshot -> NewMoviesModel in let data = queryDocumentSnapshot.data()
                    let id = data["title"] as? Int ?? 0
                    let backdropPath = data["backdropPath"] as? String ?? ""
                    let posterPath = data["posterPath"] as? String ?? ""
                    let name = data["name"] as? String ?? ""
                    
                    return NewMoviesModel(id: id, backdropPath: backdropPath, posterPath: posterPath, name: name)
                }
            }
        }
        
    }
}

// MARK: - Extensions
extension FavouritesViewModel: FavouritesInteractorOutputProtocol {
    
}

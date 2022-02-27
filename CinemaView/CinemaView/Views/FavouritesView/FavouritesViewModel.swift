//
// Created on 3/2/22.
// subfolder/FavouritesViewModel.swift - Very brief description
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

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
        
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        // Read the documents at a specific path
        dbFirebase.collection("favourites").document("\(userId)").collection("movies").getDocuments { snapshot, error in
            
            // Check for errors
            if error == nil {
                // No errors
                
                if let snapshot = snapshot {
                    
                    // Update the list property in the main thread
                    DispatchQueue.main.async {
                        
                        // Get all the documents and create Todos
                        self.arrayMoviesFav = snapshot.documents.map { queryDocumentSnapshot -> NewMoviesModel in let data = queryDocumentSnapshot.data()
                            let id = data["title"] as? Int ?? 0
                            let backdropPath = data["backdropPath"] as? String ?? ""
                            let posterPath = data["posterPath"] as? String ?? ""
                            let name = data["name"] as? String ?? ""
                            
                            return NewMoviesModel(id: id, backdropPath: backdropPath, posterPath: posterPath, name: name)
                        }
                    }
                    
                    
                }
            }
            else {
                // Handle the error
            }
        }
        
    }
}

// MARK: - Extensions
extension FavouritesViewModel: FavouritesInteractorOutputProtocol {
    
}

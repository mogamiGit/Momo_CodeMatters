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
    
    @Published var arrayMoviesFav = [NewMoviesModel]()
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
                        self.arrayMoviesFav = snapshot.documents.map { d in
                            return NewMoviesModel(id: d["id"] as? Int ?? 0,
                                                  backdropPath: d["backdropPath"] as? String ?? "",
                                                  posterPath: d["posterPath"] as? String ?? "",
                                                  name: d["name"] as? String ?? "")
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

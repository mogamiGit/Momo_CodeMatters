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
    
    @Published var movies = [NewMoviesModel]()
    private var dbFirebase = Firestore.firestore()
    
    // MARK: VIP Dependencies
    var interactor: FavouritesInteractorInputProtocol? {
        super.baseInteractor as? FavouritesInteractorInputProtocol
    }
    
//    func fetchData() {
//        dbFirebase.collection("Favourites").addSnapshotListener { (querySnapshot, error) in guard let documents = querySnapshot?.documents else {
//            print("No documents")
//            return
//          }
//
//          self.movies = documents.map { queryDocumentSnapshot -> NewMoviesModel in let data = queryDocumentSnapshot.data()
//            let title = data["title"] as? String ?? ""
//            let author = data["author"] as? String ?? ""
//            let numberOfPages = data["pages"] as? Int ?? 0
//
//            return NewMoviesModel(id: 0, backdropPath: <#T##String?#>, posterPath: <#T##String?#>, name: <#T##String?#>)
//          }
//        }
//      }
}

// MARK: - Extensions
extension FavouritesViewModel: FavouritesInteractorOutputProtocol {

}

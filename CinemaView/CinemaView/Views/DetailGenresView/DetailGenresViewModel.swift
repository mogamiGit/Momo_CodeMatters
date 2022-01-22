//
// Created on 20/1/22.
// subfolder/DetailGenresViewModel.swift - Very brief description
//

import Foundation

// MARK: - Output -> Interactor
protocol DetailGenresInteractorOutputProtocol: BaseInteractorOutputProtocol {
    func setInfoDetailGenreViewModel(data: [NewMoviesModel]?)
}

final class DetailGenresViewModel: BaseViewModel, ObservableObject {
    
    @Published var arrayDetailGenre: [NewMoviesModel] = []
    
    // MARK: VIP Dependencies
    var interactor: DetailGenresInteractorInputProtocol? {
        super.baseInteractor as? DetailGenresInteractorInputProtocol
    }
    
    func fetchData() {
        self.interactor?.fetchDataDetailGenreInteractor()
    }
}

// MARK: - Extensions
extension DetailGenresViewModel: DetailGenresInteractorOutputProtocol {
    
    func setInfoDetailGenreViewModel(data: [NewMoviesModel]?) {
        self.arrayDetailGenre.removeAll()
        self.arrayDetailGenre = data ?? []
    }
}

//
// Created on 26/1/22.
// subfolder/MoviesViewModel.swift - Very brief description
//

import Foundation

// MARK: - Output -> Interactor
protocol MoviesInteractorOutputProtocol: BaseInteractorOutputProtocol {
    func setInfoPopularMoviesViewModel(data: [NewMoviesModel]?)
}

final class MoviesViewModel: BaseViewModel, ObservableObject {
    
    @Published var arrayMoviesPopular: [NewMoviesModel] = []
    
    // MARK: VIP Dependencies
    var interactor: MoviesInteractorInputProtocol? {
        super.baseInteractor as? MoviesInteractorInputProtocol
    }
    
    func fetchData() {
        self.interactor?.fetchDataPopularMoviesInteractor()
    }
}

// MARK: - Extensions
extension MoviesViewModel: MoviesInteractorOutputProtocol {
    
    func setInfoPopularMoviesViewModel(data: [NewMoviesModel]?) {
        self.arrayMoviesPopular.removeAll()
        self.arrayMoviesPopular = data ?? []
    }
}

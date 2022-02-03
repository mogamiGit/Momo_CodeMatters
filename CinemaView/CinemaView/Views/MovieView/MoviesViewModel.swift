//
// Created on 26/1/22.
// subfolder/MoviesViewModel.swift - Very brief description
//

import Foundation

// MARK: - Output -> Interactor
protocol MoviesInteractorOutputProtocol: BaseInteractorOutputProtocol {
    func setInfoPopularMoviesViewModel(data: [NewMoviesModel]?)
    func setInfoTopRatedMoviesViewModel(data: [NewMoviesModel]?)
    func setInfoUpcomingMoviesViewModel(data: [NewMoviesModel]?)
}

final class MoviesViewModel: BaseViewModel, ObservableObject {
    
    @Published var arrayMoviesPopular: [NewMoviesModel] = []
    @Published var arrayMoviesTopRated: [NewMoviesModel] = []
    @Published var arrayMoviesUpcoming: [NewMoviesModel] = []
    
    // MARK: VIP Dependencies
    var interactor: MoviesInteractorInputProtocol? {
        super.baseInteractor as? MoviesInteractorInputProtocol
    }
    
    func fetchData() {
        self.interactor?.fetchDataPopularMoviesInteractor()
        self.interactor?.fetchDataTopRatedMoviesInteractor()
        self.interactor?.fetchDataUpcomingMoviesInteractor()
    }
}

// MARK: - Extensions
extension MoviesViewModel: MoviesInteractorOutputProtocol {
    
    func setInfoPopularMoviesViewModel(data: [NewMoviesModel]?) {
        self.arrayMoviesPopular.removeAll()
        self.arrayMoviesPopular = data ?? []
    }
    
    func setInfoTopRatedMoviesViewModel(data: [NewMoviesModel]?) {
        self.arrayMoviesTopRated.removeAll()
        self.arrayMoviesTopRated = data ?? []
    }
    
    func setInfoUpcomingMoviesViewModel(data: [NewMoviesModel]?) {
        self.arrayMoviesUpcoming.removeAll()
        self.arrayMoviesUpcoming = data ?? []
    }
}

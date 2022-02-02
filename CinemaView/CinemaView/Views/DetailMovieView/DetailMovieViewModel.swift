//
// Created on 28/1/22.
// subfolder/DetailMovieViewModel.swift - Very brief description
//

import Foundation

// MARK: - Output -> Interactor
protocol DetailMovieInteractorOutputProtocol: BaseInteractorOutputProtocol {
    func setInfoDetailMovieViewModel(data: DetailMovieModel?)
    func setInfoMovieRecommendationViewModel(data: [NewMoviesModel]?)
}

final class DetailMovieViewModel: BaseViewModel, ObservableObject {
    
    @Published var model: DetailMovieModel?
    @Published var arrayMoviesRecommended: [NewMoviesModel] = []
    
    // MARK: VIP Dependencies
    var interactor: DetailMovieInteractorInputProtocol? {
        super.baseInteractor as? DetailMovieInteractorInputProtocol
    }
    
    func fecthDataDetail() {
        self.interactor?.fetchDataDetailMovieInteractor()
        self.interactor?.fetchDataMovieRecommendationsInteractor()
    }
}

// MARK: - Extensions
extension DetailMovieViewModel: DetailMovieInteractorOutputProtocol {
    
    func setInfoDetailMovieViewModel(data: DetailMovieModel?) {
        self.model = data
        self.state = .ok
    }
    
    func setInfoMovieRecommendationViewModel(data: [NewMoviesModel]?) {
        self.arrayMoviesRecommended.removeAll()
        self.arrayMoviesRecommended = data ?? []
        self.state = .ok
    }
}

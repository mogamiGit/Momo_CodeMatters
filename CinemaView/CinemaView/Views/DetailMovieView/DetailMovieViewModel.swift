//
// Created on 28/1/22.
// subfolder/DetailMovieViewModel.swift - Very brief description
//

import Foundation

// MARK: - Output -> Interactor
protocol DetailMovieInteractorOutputProtocol: BaseInteractorOutputProtocol {
    func setInfoDetailMovieViewModel(data: DetailMovieModel?)
}

final class DetailMovieViewModel: BaseViewModel, ObservableObject {
    
    @Published var model: DetailMovieModel?
    @Published var arrayGenres: [DetailGenresViewModel] = []
    
    // MARK: VIP Dependencies
    var interactor: DetailMovieInteractorInputProtocol? {
        super.baseInteractor as? DetailMovieInteractorInputProtocol
    }
    
    func fecthDataDetail() {
        self.interactor?.fetchDataDetailMovieInteractor()
    }
}

// MARK: - Extensions
extension DetailMovieViewModel: DetailMovieInteractorOutputProtocol {
    
    func setInfoDetailMovieViewModel(data: DetailMovieModel?) {
        self.model = data
        self.state = .ok
    }
}

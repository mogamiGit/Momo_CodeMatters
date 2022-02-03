//
// Created on 28/1/22.
// subfolder/DetailMovieInteractor.swift - Very brief description
//

import Foundation

// MARK: - Input Interactor
protocol DetailMovieInteractorInputProtocol: BaseInteractorInputProtocol {
    func fetchDataDetailMovieInteractor()
    func fetchDataMovieRecommendationsInteractor()
    func saveDataInFirebaseDB(data: DetailMovieModel)
}
// MARK: - Output -> Provider
protocol DetailMovieProviderOutputProtocol: BaseProviderOutputProtocol {
    func setInfoDetailMovie(completionData: Result<DetailMovieModel?, NetworkingError>)
    func setInfoMoviesRecommendation(completionData: Result<[ResultMovies]?, NetworkingError>)
}

class DetailMovieInteractor: BaseInteractor {
    
    // MARK: VIP Dependencies
    weak var viewModel: DetailMovieInteractorOutputProtocol? {
        super.baseViewModel as? DetailMovieInteractorOutputProtocol
    }
    
    var provider: DetailMovieProviderInputProtocol? {
        super.baseProvider as? DetailMovieProviderInputProtocol
    }
    
    func transformDataDetailMovieToNewMoviesModel(data: [ResultMovies]?) -> [NewMoviesModel]? {
        var arrayMoviesModel: [NewMoviesModel] = []
        if let dataDes = data {
            for index in 0..<dataDes.count {
                let object = NewMoviesModel(id: dataDes[index].id,
                                            backdropPath: dataDes[index].backdropPath,
                                            posterPath: dataDes[index].posterPath,
                                            name: dataDes[index].title)
                arrayMoviesModel.append(object)
            }
        }
        return arrayMoviesModel
    }

}

// MARK: - Extensions
extension DetailMovieInteractor: DetailMovieInteractorInputProtocol {
    
    func fetchDataDetailMovieInteractor() {
        self.provider?.fetchDataDetailMovieWithParametersProvider()
    }
    
    func fetchDataMovieRecommendationsInteractor() {
        self.provider?.fetchDataMovieRecommendationsProvider()
    }
    
    func saveDataInFirebaseDB(data: DetailMovieModel) {
        self.provider?.saveDataInFirebaseDBProvider(data: data)
    }
}

extension DetailMovieInteractor: DetailMovieProviderOutputProtocol {
    
    func setInfoDetailMovie(completionData: Result<DetailMovieModel?, NetworkingError>) {
        switch completionData {
        case .success(let data):
            self.viewModel?.setInfoDetailMovieViewModel(data: data)
        case .failure(let error):
            debugPrint(error)
        }
    }
    
    func setInfoMoviesRecommendation(completionData: Result<[ResultMovies]?, NetworkingError>) {
        switch completionData{
        case .success(let data):
            self.viewModel?.setInfoMovieRecommendationViewModel(data: self.transformDataDetailMovieToNewMoviesModel(data: data))
        case .failure(let error):
            debugPrint(error)
        }
    }
}

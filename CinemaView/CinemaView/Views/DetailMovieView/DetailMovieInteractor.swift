//
// Created on 28/1/22.
// subfolder/DetailMovieInteractor.swift - Very brief description
//

import Foundation

// MARK: - Input Interactor
protocol DetailMovieInteractorInputProtocol: BaseInteractorInputProtocol {
    func fetchDataDetailMovieInteractor()
}
// MARK: - Output -> Provider
protocol DetailMovieProviderOutputProtocol: BaseProviderOutputProtocol {
    func setInfoDetailMovie(completionData: Result<DetailMovieModel?, NetworkingError>)
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
}

extension DetailMovieInteractor: DetailMovieProviderOutputProtocol {
    
    func setInfoDetailMovie(completionData: Result<DetailMovieModel?, NetworkingError>) {
        switch completionData{
        case .success(let data):
            self.viewModel?.setInfoDetailMovieViewModel(data: data)
        case .failure(let error):
            debugPrint(error)
        }
    }
}

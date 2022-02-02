//
// Created on 26/1/22.
// subfolder/MoviesInteractor.swift - Very brief description
//

import Foundation

// MARK: - Input Interactor
protocol MoviesInteractorInputProtocol: BaseInteractorInputProtocol {
    func fetchDataPopularMoviesInteractor()
    func fetchDataTopRatedMoviesInteractor()
    func fetchDataUpcomingMoviesInteractor()
}
// MARK: - Output -> Provider
protocol MoviesProviderOutputProtocol: BaseProviderOutputProtocol {
    func setInfoPopularMovies(completionData: Result<[ResultMovies]?, NetworkingError>)
    func setInfoTopRatedMovies(completionData: Result<[ResultMovies]?, NetworkingError>)
    func setInfoUpcomingMovies(completionData: Result<[ResultMovies]?, NetworkingError>)
}

class MoviesInteractor: BaseInteractor {
    
    // MARK: VIP Dependencies
    weak var viewModel: MoviesInteractorOutputProtocol? {
        super.baseViewModel as? MoviesInteractorOutputProtocol
    }
    
    var provider: MoviesProviderInputProtocol? {
        super.baseProvider as? MoviesProviderInputProtocol
    }
    
    func transformDataMoviesToNewMoviesModel(data: [ResultMovies]?) -> [NewMoviesModel]? {
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
extension MoviesInteractor: MoviesInteractorInputProtocol {
    
    func fetchDataPopularMoviesInteractor() {
        self.provider?.fetchDataPopularMoviesProvider()
    }
    
    func fetchDataTopRatedMoviesInteractor() {
        self.provider?.fetchDataTopRatedMoviesProvider()
    }
    
    func fetchDataUpcomingMoviesInteractor() {
        self.provider?.fetchDataUpcomingMoviesProvider()
    }
}

extension MoviesInteractor: MoviesProviderOutputProtocol {
    
    func setInfoPopularMovies(completionData: Result<[ResultMovies]?, NetworkingError>) {
        switch completionData{
        case .success(let data):
            self.viewModel?.setInfoPopularMoviesViewModel(data: self.transformDataMoviesToNewMoviesModel(data: data))
        case .failure(let error):
            debugPrint(error)
        }
    }
    
    func setInfoTopRatedMovies(completionData: Result<[ResultMovies]?, NetworkingError>) {
        switch completionData{
        case .success(let data):
            self.viewModel?.setInfoTopRatedMoviesViewModel(data: self.transformDataMoviesToNewMoviesModel(data: data))
        case .failure(let error):
            debugPrint(error)
        }
    }
    
    func setInfoUpcomingMovies(completionData: Result<[ResultMovies]?, NetworkingError>) {
        switch completionData{
        case .success(let data):
            self.viewModel?.setInfoUpcomingMoviesViewModel(data: self.transformDataMoviesToNewMoviesModel(data: data))
        case .failure(let error):
            debugPrint(error)
        }
    }
}

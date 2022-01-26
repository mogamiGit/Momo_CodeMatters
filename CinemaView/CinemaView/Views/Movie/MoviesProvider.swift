//
// Created on 26/1/22.
// subfolder/MoviesProvider.swift - Very brief description
//

import Foundation
import Combine

// MARK: - Input Provider
protocol MoviesProviderInputProtocol: BaseProviderInputProtocol {
    func fetchDataPopularMoviesProvider()
}

final class MoviesProvider: BaseProvider {

    // MARK: VIP Dependences
    weak var interactor: MoviesProviderOutputProtocol? {
        super.baseInteractor as? MoviesProviderOutputProtocol
    }
    
    let networkService: NetworkServiceProtocol = NetworkService()
    var cancellable: Set<AnyCancellable> = []
    
}

// MARK: - Extensions
extension MoviesProvider: MoviesProviderInputProtocol {
    
    func fetchDataPopularMoviesProvider() {
        let request = RequestDTO(params: nil,
                                 arrayParams: nil,
                                 method: .get,
                                 urlContext: .webService,
                                 endpoint: URLEndpoint.endpointMoviesPopular)
        
        self.networkService.requestGeneric(request: request,
                                           entityClass: MoviesModel.self)
            .sink { completion in
                switch completion{
                case .finished: break
                case .failure(let error):
                    self.interactor?.setInfoPopularMovies(completionData: .failure(error))
                }
            } receiveValue: { resultData in
                self.interactor?.setInfoPopularMovies(completionData: .success(resultData.results))
            }
            .store(in: &cancellable)
    }
    
}



//
// Created on 28/1/22.
// subfolder/DetailMovieProvider.swift - Very brief description
//

import Foundation
import Combine

// MARK: - Input Provider
protocol DetailMovieProviderInputProtocol: BaseProviderInputProtocol {
    func fetchDataDetailMovieWithParametersProvider()
}

final class DetailMovieProvider: BaseProvider {

    // MARK: VIP Dependences
    weak var interactor: DetailMovieProviderOutputProtocol? {
        super.baseInteractor as? DetailMovieProviderOutputProtocol
    }
    
    let networkService: NetworkServiceProtocol = NetworkService()
    var cancellable: Set<AnyCancellable> = []
    
    var movieObject: NewMoviesModel?
    let supportParameters = "videos,credits"
    
}

// MARK: - Extensions
extension DetailMovieProvider: DetailMovieProviderInputProtocol {
    
    func fetchDataDetailMovieWithParametersProvider() {
        let movieId = "\(movieObject?.id ?? 0)"
        let parameters: [CVarArg] = [movieId, supportParameters]
        let finalEndpoint = String(format: URLEndpoint.endpointDetailMovie, arguments: parameters)
        let request = RequestDTO(params: nil,
                                 arrayParams: nil,
                                 method: .get,
                                 urlContext: .webService,
                                 endpoint: finalEndpoint)
        
        self.networkService.requestGeneric(request: request,
                                           entityClass: DetailMovieModel.self)
            .sink { completion in
                switch completion{
                case .finished: break
                case .failure(let error):
                    self.interactor?.setInfoDetailMovie(completionData: .failure(error))
                }
            } receiveValue: { resultData in
                self.interactor?.setInfoDetailMovie(completionData: .success(resultData))
            }
            .store(in: &cancellable)
    }
}



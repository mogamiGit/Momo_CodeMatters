//
// Created on 17/1/22.
// subfolder/GenresProvider.swift - Very brief description
//

import Foundation
import Combine

// MARK: - Input Provider
protocol GenresProviderInputProtocol: BaseProviderInputProtocol {
    func fetchDataGenresProvider()
}

final class GenresProvider: BaseProvider {

    // MARK: VIP Dependences
    weak var interactor: GenresProviderOutputProtocol? {
        super.baseInteractor as? GenresProviderOutputProtocol
    }
    
    let networkService: NetworkServiceProtocol = NetworkService()
    var cancellable: Set<AnyCancellable> = []
    
}

// MARK: - Extensions
extension GenresProvider: GenresProviderInputProtocol {
    
    func fetchDataGenresProvider() {
        let request = RequestDTO(params: nil,
                                 arrayParams: nil,
                                 method: .get,
                                 urlContext: .webService,
                                 endpoint: URLEndpoint.endpointMoviesGenre)
        
        self.networkService.requestGeneric(request: request,
                                           entityClass: GenresModel.self)
            .sink { completion in
                switch completion{
                case .finished: break
                case .failure(let error):
                    self.interactor?.setInfoGenres(completionData: .failure(error))
                }
            } receiveValue: { resultData in
                self.interactor?.setInfoGenres(completionData: .success(resultData.genres))
            }
            .store(in: &cancellable)
    }
}



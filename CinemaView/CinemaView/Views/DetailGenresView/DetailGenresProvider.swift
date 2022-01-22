//
// Created on 20/1/22.
// subfolder/DetailGenresProvider.swift - Very brief description
//

import Foundation
import Combine

// MARK: - Input Provider
protocol DetailGenresProviderInputProtocol: BaseProviderInputProtocol {
    func fetchDataDetailGenreProvider()
}

final class DetailGenresProvider: BaseProvider {

    // MARK: VIP Dependences
    weak var interactor: DetailGenresProviderOutputProtocol? {
        super.baseInteractor as? DetailGenresProviderOutputProtocol
    }
    
    let networkService: NetworkServiceProtocol = NetworkService()
    var cancellable: Set<AnyCancellable> = []
    
    var genreObject: NewGenresModel?
    
}

// MARK: - Extensions
extension DetailGenresProvider: DetailGenresProviderInputProtocol {
    
    func fetchDataDetailGenreProvider() {
        let genreId = "\(genreObject?.id ?? 0)"
        let parameters: [CVarArg] = [genreId]
        let finalEndpoint = String(format: URLEndpoint.endpointDetailMoviesGenre, arguments: parameters)
        let request = RequestDTO(params: nil,
                                 arrayParams: nil,
                                 method: .get,
                                 urlContext: .webService,
                                 endpoint: finalEndpoint)
        
        self.networkService.requestGeneric(request: request,
                                           entityClass: DetailGenreFilterModel.self)
            .sink { completion in
                switch completion{
                case .finished: break
                case .failure(let error):
                    self.interactor?.setInfoDetailGenre(completionData: .failure(error))
                }
            } receiveValue: { resultData in
                self.interactor?.setInfoDetailGenre(completionData: .success(resultData.results))
            }
            .store(in: &cancellable)
    }
}



//
// Created on 28/1/22.
// subfolder/DetailMovieProvider.swift - Very brief description
//

import Foundation
import Combine
import FirebaseFirestore

// MARK: - Input Provider
protocol DetailMovieProviderInputProtocol: BaseProviderInputProtocol {
    func fetchDataDetailMovieWithParametersProvider()
    func fetchDataMovieRecommendationsProvider()
    func saveDataInFirebaseDBProvider(data: DetailMovieModel)
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
    private var dbFirebase = Firestore.firestore()
    
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
    
    func fetchDataMovieRecommendationsProvider() {
        let movieId = "\(movieObject?.id ?? 0)"
        let parameters: [CVarArg] = [movieId]
        let finalEndpoint = String(format: URLEndpoint.endpointMovieRecommendation, arguments: parameters)
        let request = RequestDTO(params: nil,
                                 arrayParams: nil,
                                 method: .get,
                                 urlContext: .webService,
                                 endpoint: finalEndpoint)
        
        self.networkService.requestGeneric(request: request,
                                           entityClass: MoviesModel.self)
            .sink { completion in
                switch completion{
                case .finished: break
                case .failure(let error):
                    self.interactor?.setInfoMoviesRecommendation(completionData: .failure(error))
                }
            } receiveValue: { resultData in
                self.interactor?.setInfoMoviesRecommendation(completionData: .success(resultData.results))
            }
            .store(in: &cancellable)
    }
    
    func saveDataInFirebaseDBProvider(data: DetailMovieModel) {
        
        let userId = "m.galan"
        let movieId = "\(movieObject?.id ?? 0)"
        
        let movieDetails : [String: Any] = [
            "id" : "\(data.id ?? 0)",
            "backdropPath":"\(data.backdropPath ?? "")",
            "posterPath":"\(data.posterPath ?? "")",
            "name":"\(data.title ?? "")"
        ]
        
        let docRef = dbFirebase.collection("favourites").document("\(userId)")
        
        if "\(data.id ?? 0)" == movieId {
            docRef.collection("movies").document().setData(movieDetails, merge: true)
        }
    }
    
}



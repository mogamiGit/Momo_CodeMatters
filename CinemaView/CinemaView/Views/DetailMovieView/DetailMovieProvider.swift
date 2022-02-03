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
        
        let docRef = dbFirebase.collection("Favourites").document("movies")
        let movieId = "\(movieObject?.id ?? 0)"
        
        if "\(data.id ?? 0)" == movieId {
            docRef.setData(["id": "\(data.id ?? 0)"], merge: true) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
        }
    }
    
}



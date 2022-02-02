//
// Created on 20/1/22.
// subfolder/DetailGenresInteractor.swift - Very brief description
//

import Foundation

// MARK: - Input Interactor
protocol DetailGenresInteractorInputProtocol: BaseInteractorInputProtocol {
    func fetchDataDetailGenreInteractor()
}
// MARK: - Output -> Provider
protocol DetailGenresProviderOutputProtocol: BaseProviderOutputProtocol {
    func setInfoDetailGenre(completionData: Result<[ResultFilterGenre]?, NetworkingError>)
}

class DetailGenresInteractor: BaseInteractor {
    
    // MARK: VIP Dependencies
    weak var viewModel: DetailGenresInteractorOutputProtocol? {
        super.baseViewModel as? DetailGenresInteractorOutputProtocol
    }
    
    var provider: DetailGenresProviderInputProtocol? {
        super.baseProvider as? DetailGenresProviderInputProtocol
    }
    
    func transformDataDetailGenreToNewGenresModel(data: [ResultFilterGenre]?) -> [NewMoviesModel]? {
        var arrayDetailGenreModel: [NewMoviesModel] = []
        if let dataDes = data {
            for index in 0..<dataDes.count {
                let object = NewMoviesModel(id: dataDes[index].id, backdropPath: dataDes[index].backdropPath, posterPath: dataDes[index].posterPath, name: dataDes[index].title)
                arrayDetailGenreModel.append(object)
            }
        }
        return arrayDetailGenreModel
    }

}

// MARK: - Extensions
extension DetailGenresInteractor: DetailGenresInteractorInputProtocol {
    
    func fetchDataDetailGenreInteractor() {
        self.provider?.fetchDataDetailGenreProvider()
    }
}

extension DetailGenresInteractor: DetailGenresProviderOutputProtocol {
    
    func setInfoDetailGenre(completionData: Result<[ResultFilterGenre]?, NetworkingError>) {
        
        switch completionData{
        case .success(let data):
            self.viewModel?.setInfoDetailGenreViewModel(data: self.transformDataDetailGenreToNewGenresModel(data: data))
        case .failure(let error):
            debugPrint(error)
        }
    }
}

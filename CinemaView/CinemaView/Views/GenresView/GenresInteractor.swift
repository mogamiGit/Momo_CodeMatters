//
// Created on 17/1/22.
// subfolder/GenresInteractor.swift - Very brief description
//

import Foundation

// MARK: - Input Interactor
protocol GenresInteractorInputProtocol: BaseInteractorInputProtocol {
    func fetchDataGenresInteractor()
}
// MARK: - Output -> Provider
protocol GenresProviderOutputProtocol: BaseProviderOutputProtocol {
    func setInfoGenres(completionData: Result<[Genre]?, NetworkingError>)
}

class GenresInteractor: BaseInteractor {
    
    // MARK: VIP Dependencies
    weak var viewModel: GenresInteractorOutputProtocol? {
        super.baseViewModel as? GenresInteractorOutputProtocol
    }
    
    var provider: GenresProviderInputProtocol? {
        super.baseProvider as? GenresProviderInputProtocol
    }
    
    func transformDataGenresToNewGenresModel(data: [Genre]?) -> [NewGenresModel]? {
        var arrayGenresModel: [NewGenresModel] = []
        if let dataDes = data {
            for index in 0..<dataDes.count {
                let object = NewGenresModel(id: dataDes[index].id,
                                            name: dataDes[index].name)
                arrayGenresModel.append(object)
            }
        }
        return arrayGenresModel
    }

}

// MARK: - Extensions
extension GenresInteractor: GenresInteractorInputProtocol {
    
    func fetchDataGenresInteractor() {
        self.provider?.fetchDataGenresProvider()
    }
    
}

extension GenresInteractor: GenresProviderOutputProtocol {
    
    func setInfoGenres(completionData: Result<[Genre]?, NetworkingError>) {
        
        switch completionData{
        case .success(let data):
            self.viewModel?.setInfoGenresViewModel(data: self.transformDataGenresToNewGenresModel(data: data))
        case .failure(let error):
            debugPrint(error)
        }
    }
}

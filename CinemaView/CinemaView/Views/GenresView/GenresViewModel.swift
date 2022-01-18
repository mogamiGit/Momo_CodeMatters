//
// Created on 17/1/22.
// subfolder/GenresViewModel.swift - Very brief description
//

import Foundation

// MARK: - Output -> Interactor
protocol GenresInteractorOutputProtocol: BaseInteractorOutputProtocol {
    func setInfoGenresViewModel(data: [NewGenresModel]?)
}

final class GenresViewModel: BaseViewModel, ObservableObject {
    
    @Published var arrayGenres: [NewGenresModel] = []
    
    // MARK: VIP Dependencies
    var interactor: GenresInteractorInputProtocol? {
        super.baseInteractor as? GenresInteractorInputProtocol
    }
    
    func fetchData() {
        self.interactor?.fetchDataGenresInteractor()
    }
}

// MARK: - Extensions
extension GenresViewModel: GenresInteractorOutputProtocol {
    
    func setInfoGenresViewModel(data: [NewGenresModel]?) {
        self.arrayGenres.removeAll()
        self.arrayGenres = data ?? []
    }
}

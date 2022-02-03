//
// Created on 3/2/22.
// subfolder/FavouritesProvider.swift - Very brief description
//

import Foundation
import Combine

// MARK: - Input Provider
protocol FavouritesProviderInputProtocol: BaseProviderInputProtocol {
    
}

final class FavouritesProvider: BaseProvider {

    // MARK: VIP Dependences
    weak var interactor: FavouritesProviderOutputProtocol? {
        super.baseInteractor as? FavouritesProviderOutputProtocol
    }
    
    let networkService: NetworkServiceProtocol = NetworkService()
    var cancellable: Set<AnyCancellable> = []
    
}

// MARK: - Extensions
extension FavouritesProvider: FavouritesProviderInputProtocol {
    
}



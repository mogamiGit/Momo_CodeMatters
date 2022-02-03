//
// Created on 3/2/22.
// subfolder/FavouritesInteractor.swift - Very brief description
//

import Foundation

// MARK: - Input Interactor
protocol FavouritesInteractorInputProtocol: BaseInteractorInputProtocol {
    
}
// MARK: - Output -> Provider
protocol FavouritesProviderOutputProtocol: BaseProviderOutputProtocol {
    
}

class FavouritesInteractor: BaseInteractor {
    
    // MARK: VIP Dependencies
    weak var viewModel: FavouritesInteractorOutputProtocol? {
        super.baseViewModel as? FavouritesInteractorOutputProtocol
    }
    
    var provider: FavouritesProviderInputProtocol? {
        super.baseProvider as? FavouritesProviderInputProtocol
    }

}

// MARK: - Extensions
extension FavouritesInteractor: FavouritesInteractorInputProtocol {

}

extension FavouritesInteractor: FavouritesProviderOutputProtocol {

}

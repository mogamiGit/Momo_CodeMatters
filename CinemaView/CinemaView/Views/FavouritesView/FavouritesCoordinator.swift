//
// Created on 3/2/22.
// subfolder/FavouritesCoordinator.swift - Very brief description
//

import Foundation
import SwiftUI

final class FavouritesCoordinator: BaseCoordinator {
    
    typealias ContentView = FavouritesView
    typealias ViewModel = FavouritesViewModel
    typealias Interactor = FavouritesInteractor
    typealias Provider = FavouritesProvider
    
    static func navigation(dto: FavouritesCoordinatorDTO? = nil) -> NavigationView<ContentView> {
        NavigationView {
            self.view()
        }
    }
    
    static func view(dto: FavouritesCoordinatorDTO? = nil) -> ContentView {
        let vip = BaseCoordinator.coordinator(viewModel: ViewModel.self,
                                              interactor: Interactor.self,
                                              provider: Provider.self)
        
        let view = ContentView(viewModel: vip.viewModel)
        return view
    }
}

struct FavouritesCoordinatorDTO {
    
}


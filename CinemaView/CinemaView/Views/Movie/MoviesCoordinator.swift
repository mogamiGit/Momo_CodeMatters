//
// Created on 26/1/22.
// subfolder/MoviesCoordinator.swift - Very brief description
//

import Foundation
import SwiftUI

final class MoviesCoordinator: BaseCoordinator {
    
    typealias ContentView = MoviesView
    typealias ViewModel = MoviesViewModel
    typealias Interactor = MoviesInteractor
    typealias Provider = MoviesProvider
    
    static func navigation(dto: MoviesCoordinatorDTO? = nil) -> NavigationView<ContentView> {
        NavigationView {
            self.view()
        }
    }
    
    static func view(dto: MoviesCoordinatorDTO? = nil) -> ContentView {
        let vip = BaseCoordinator.coordinator(viewModel: ViewModel.self,
                                              interactor: Interactor.self,
                                              provider: Provider.self)
        
        let view = ContentView(viewModel: vip.viewModel)
        return view
    }
}

struct MoviesCoordinatorDTO {
    
}


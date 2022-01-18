//
// Created on 17/1/22.
// subfolder/GenresCoordinator.swift - Very brief description
//

import Foundation
import SwiftUI

final class GenresCoordinator: BaseCoordinator {
    
    typealias ContentView = GenresView
    typealias ViewModel = GenresViewModel
    typealias Interactor = GenresInteractor
    typealias Provider = GenresProvider
    
    static func navigation() -> NavigationView<ContentView> {
        NavigationView {
            self.view()
        }
    }
    
    static func view() -> ContentView {
        let vip = BaseCoordinator.coordinator(viewModel: ViewModel.self,
                                              interactor: Interactor.self,
                                              provider: Provider.self)
        
        let view = ContentView(viewModel: vip.viewModel)
        return view
    }
}


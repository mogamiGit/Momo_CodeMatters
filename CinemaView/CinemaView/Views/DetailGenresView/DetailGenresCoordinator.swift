//
// Created on 20/1/22.
// subfolder/DetailGenresCoordinator.swift - Very brief description
//

import Foundation
import SwiftUI

final class DetailGenresCoordinator: BaseCoordinator {
    
    typealias ContentView = DetailGenresView
    typealias ViewModel = DetailGenresViewModel
    typealias Interactor = DetailGenresInteractor
    typealias Provider = DetailGenresProvider
    
    static func navigation(dto: DetailGenresCoordinatorDTO? = nil) -> NavigationView<ContentView> {
        NavigationView {
            self.view()
        }
    }
    
    static func view(dto: DetailGenresCoordinatorDTO? = nil) -> ContentView {
        let vip = BaseCoordinator.coordinator(viewModel: ViewModel.self,
                                              interactor: Interactor.self,
                                              provider: Provider.self)
        
        vip.provider.genreObject = dto?.genreObject ?? NewGenresModel(id: 0, name: "")
        
        let view = ContentView(viewModel: vip.viewModel)
        return view
    }
}

struct DetailGenresCoordinatorDTO {
    var genreObject: NewGenresModel
}


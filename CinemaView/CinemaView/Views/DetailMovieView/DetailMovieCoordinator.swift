//
// Created on 28/1/22.
// subfolder/DetailMovieCoordinator.swift - Very brief description
//

import Foundation
import SwiftUI

final class DetailMovieCoordinator: BaseCoordinator {
    
    typealias ContentView = DetailMovieView
    typealias ViewModel = DetailMovieViewModel
    typealias Interactor = DetailMovieInteractor
    typealias Provider = DetailMovieProvider
    
    static func navigation(dto: DetailMovieCoordinatorDTO? = nil) -> NavigationView<ContentView> {
        NavigationView {
            self.view()
        }
    }
    
    static func view(dto: DetailMovieCoordinatorDTO? = nil) -> ContentView {
        let vip = BaseCoordinator.coordinator(viewModel: ViewModel.self,
                                              interactor: Interactor.self,
                                              provider: Provider.self)
        
        vip.provider.movieObject = dto?.movieObject ?? NewMoviesModel(id: 0,
                                                                        backdropPath: "",
                                                                        posterPath: "",
                                                                        name: "")
        
        let view = ContentView(viewModel: vip.viewModel)
        return view
    }
}

struct DetailMovieCoordinatorDTO {
    var movieObject: NewMoviesModel
}


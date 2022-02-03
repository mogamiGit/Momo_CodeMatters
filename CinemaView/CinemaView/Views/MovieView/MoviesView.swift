//
// Created on 26/1/22.
// subfolder/MoviesView.swift - Very brief description
//

import SwiftUI

struct MoviesView: View {
    
    // MARK: ObservedObject -> MVVM Dependencies
    @ObservedObject var viewModel: MoviesViewModel
    
    var body: some View {
        ZStack {
            Color.hex(Constants.Colors.backgroundColor).ignoresSafeArea()
            
            ScrollView() {
                VStack(spacing: 10) {
                    TitleSectionView(title: "Movies")
                    
                    VStack(alignment: .leading, spacing: 30) {
                        Group {
                            if !self.viewModel.arrayMoviesPopular.isEmpty {
                                GenericCarouselView(title: "Popular", colorHex: Constants.Colors.primaryColor, isPosterFromMoviesView: true, moviesModel: self.viewModel.arrayMoviesPopular)
                            }
                        }
                        
                        Group {
                            if !self.viewModel.arrayMoviesTopRated.isEmpty {
                                GenericCarouselView(title: "Top Rated", colorHex: Constants.Colors.secondaryColor, isPosterFromMoviesView: false, moviesModel: self.viewModel.arrayMoviesTopRated)
                            }
                        }
                        
                        Group {
                            if !self.viewModel.arrayMoviesUpcoming.isEmpty {
                                GenericCarouselView(title: "Upcoming", colorHex: Constants.Colors.secondaryColor, isPosterFromMoviesView: true, moviesModel: self.viewModel.arrayMoviesUpcoming)
                            }
                        }
                    }
                    .padding(.bottom, 80)
                }
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear{
            self.viewModel.fetchData()
        }
    }
}

//struct Movies_Previews: PreviewProvider {
//    static var previews: some View {
//        MoviesView(viewModel: MoviesViewModel())
//            .environment(\.colorScheme, .dark)
//    }
//}



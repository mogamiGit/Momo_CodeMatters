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
            
            VStack(spacing: 10) {
                TitleSectionView(title: "Movies")
                
                Group {
                    if !self.viewModel.arrayMoviesPopular.isEmpty {
                        GenericCarouselView(title: "Popular", colorHex: Constants.Colors.primaryColor, isPosterFromMoviesView: true, moviesModel: self.viewModel.arrayMoviesPopular)
                    }
                }
                .listRowInsets(EdgeInsets(top: 16,
                                          leading: 0,
                                          bottom: 8,
                                          trailing: 0))
                
                Spacer()
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



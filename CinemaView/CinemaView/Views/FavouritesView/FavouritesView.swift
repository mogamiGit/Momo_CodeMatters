//
// Created on 3/2/22.
// subfolder/FavouritesView.swift - Very brief description
//

import SwiftUI

struct FavouritesView: View {
    
    // MARK: ObservedObject -> MVVM Dependencies
    @ObservedObject var viewModel: FavouritesViewModel
    
    var body: some View {
        ZStack {
            Color.hex(Constants.Colors.backgroundColor).ignoresSafeArea()
            VStack(spacing: 10) {
                TitleSectionView(title: "My Favourites")
                
                List() {
                    ForEach(self.viewModel.arrayMoviesFav) { movie in
                        movieFavCell(model: movie)
                    }
                }
                .listRowInsets(EdgeInsets(top: 16,
                                           leading: 0,
                                           bottom: 0,
                                           trailing: 0))
                
                Spacer()
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear() {
            self.viewModel.fetchData()
        }
    }
}

struct movieFavCell: View {
    private var movieModel: NewMoviesModel
    
    init(model: NewMoviesModel) {
        self.movieModel = model
    }
    
    var body: some View {
        Text(movieModel.name ?? "")
            .lineLimit(1)
            .padding(.bottom)
    }
}

//struct Favourites_Previews: PreviewProvider {
//    static var previews: some View {
//        FavouritesView(viewModel: FavouritesViewModel())
//            .environment(\.colorScheme, .dark)
//    }
//}



//
// Created on 3/2/22.
// subfolder/FavouritesView.swift - Very brief description
//

import SwiftUI

struct FavouritesView: View {
    
    // MARK: ObservedObject -> MVVM Dependencies
    @ObservedObject var viewModel: FavouritesViewModel
    
    @State var id = 0
    @State var backdropPath = ""
    @State var posterPath = ""
    @State var name = ""
    
    
    var body: some View {
        ZStack {
            Color.hex(Constants.Colors.backgroundColor).ignoresSafeArea()
            VStack(spacing: 10) {
                TitleSectionView(title: "My Favourites")
                
                List(self.viewModel.arrayMoviesFav) { movie in
                    movieFavCell(model: movie)
                }.listRowInsets(EdgeInsets(top: 16,
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
    @ObservedObject var imageLoaderVM = ImageLoader()
    
    private var movieModel: NewMoviesModel
    
    init(model: NewMoviesModel) {
        self.movieModel = model
        self.imageLoaderVM.loadImage(whit: model.posterUrl)
    }
    
    var body: some View {
        HStack(spacing:20) {
            ZStack {
                if self.imageLoaderVM.image != nil {
                    Image(uiImage: self.imageLoaderVM.image!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 80, height: 80)
                        .cornerRadius(8)
                        .shadow(radius: 10)
                } else {
                    ZStack{
                        Rectangle()
                            .fill(LinearGradient(gradient: Gradient(colors: [Color.hex(Constants.Colors.primaryColor), Color.clear]),
                                                 startPoint: .top,
                                                 endPoint: .bottom))
                            .frame(width: 80, height: 80)
                            .cornerRadius(6)
                    }
                }
            }
            VStack {
                Spacer()
                Text(movieModel.name ?? "")
                    .font(.title2)
                    .lineLimit(1)
                    .padding(.bottom)
            }
        }
        
    }
}

//struct Favourites_Previews: PreviewProvider {
//    static var previews: some View {
//        FavouritesView(viewModel: FavouritesViewModel())
//            .environment(\.colorScheme, .dark)
//    }
//}



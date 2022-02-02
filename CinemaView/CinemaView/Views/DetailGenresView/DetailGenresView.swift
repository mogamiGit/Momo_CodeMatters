//
// Created on 20/1/22.
// subfolder/DetailGenresView.swift - Very brief description
//

import SwiftUI

struct DetailGenresView: View {
    
    // MARK: ObservedObject -> MVVM Dependencies
    @ObservedObject var viewModel: DetailGenresViewModel
    
    var body: some View {
        ZStack {
            Color.hex(Constants.Colors.backgroundColor).ignoresSafeArea()
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: Array(repeating: GridItem(), count: 2)) {
                        ForEach(self.viewModel.arrayDetailGenre ?? []) { movie in
                            NavigationLink(destination: DetailMovieCoordinator.view(
                                dto: DetailMovieCoordinatorDTO(movieObject: movie))) {
                                    DetailGenreCell(model: movie)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 80)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear{
            self.viewModel.fetchData()
        }
    }
}

struct DetailGenreCell: View {
    
    @ObservedObject var imageLoaderVM = ImageLoader()
    private var movieModel: NewMoviesModel
    
    init(model: NewMoviesModel) {
        self.movieModel = model
        self.imageLoaderVM.loadImage(whit: model.posterUrl)
    }
    
    var body: some View {
        
        VStack(spacing: 20) {
            ZStack {
                if self.imageLoaderVM.image != nil {
                    Image(uiImage: self.imageLoaderVM.image!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(8)
                        .shadow(radius: 10)
                } else {
                    ZStack{
                        Rectangle()
                            .fill(LinearGradient(gradient: Gradient(colors: [Color.hex(Constants.Colors.primaryColor), Color.clear]),
                                                 startPoint: .top,
                                                 endPoint: .bottom))
                            .frame(width: 160, height: 240)
                            .cornerRadius(8)
                    }
                }
            }
            
            Text(movieModel.name ?? "")
                .lineLimit(1)
                .padding(.bottom)
        }
        .padding(.horizontal, 10)
    }
}

//struct DetailGenres_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailGenresView(viewModel: DetailGenresViewModel())
//            .environment(\.colorScheme, .dark)
//    }
//}



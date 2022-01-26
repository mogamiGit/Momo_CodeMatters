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
                        ForEach(self.viewModel.arrayDetailGenre ?? []) { item in
                            DetailGenreCell(model: item)
                            }
                        }
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
    
    private var moviesModel: NewMoviesModel
    
    init(model: NewMoviesModel) {
        self.moviesModel = model
        self.imageLoaderVM.loadImage(whit: model.posterUrl)
    }
    
    var body: some View {
        VStack() {
            Text(moviesModel.title ?? "")
            if self.imageLoaderVM.image != nil {
                Image(uiImage: self.imageLoaderVM.image!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(8)
                    .shadow(radius: 10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.red, lineWidth: 1)
                    )
            }
        }
    }
}

//struct DetailGenres_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailGenresView(viewModel: DetailGenresViewModel())
//            .environment(\.colorScheme, .dark)
//    }
//}



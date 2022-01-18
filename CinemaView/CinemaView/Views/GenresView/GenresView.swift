//
// Created on 17/1/22.
// subfolder/GenresView.swift - Very brief description
//

import SwiftUI

struct GenresView: View {
    
    // MARK: ObservedObject -> MVVM Dependencies
    @ObservedObject var viewModel: GenresViewModel
    
    var body: some View {
        VStack{
            Text("hello world!")
                .fontWeight(.bold)
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: Array(repeating: GridItem(), count: 2)) {
                    if self.viewModel.arrayGenres != nil {
                        ForEach(self.viewModel.arrayGenres ?? []) { item in
                            GenreCell(model: item)
                        }
                    }
                }
            }
        }
        .onAppear{
            self.viewModel.fetchData()
        }
    }
}

struct GenreCell: View {
    
    var genresModel: NewGenresModel
    
    init(model: NewGenresModel) {
        self.genresModel = model
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text(genresModel.name ?? "").font(.callout).lineLimit(1).foregroundColor(.white)
        }
        .background(Color.black)
        .padding(.horizontal, 5)
    }
}

struct Genres_Previews: PreviewProvider {
    static var previews: some View {
        GenresView(viewModel: GenresViewModel())
            .environment(\.colorScheme, .dark)
    }
}



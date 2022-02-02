//
// Created on 17/1/22.
// subfolder/GenresView.swift - Very brief description
//

import SwiftUI

struct GenresView: View {
    
    // MARK: ObservedObject -> MVVM Dependencies
    @ObservedObject var viewModel: GenresViewModel
    
    var body: some View {
        ZStack {
            Color.hex(Constants.Colors.backgroundColor).ignoresSafeArea()
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    TitleSectionView(title: "Genres")
                    LazyVGrid(columns: Array(repeating: GridItem(), count: 2)) {
                        ForEach(self.viewModel.arrayGenres ?? []) { item in
                            NavigationLink(destination: DetailGenresCoordinator.view(dto: DetailGenresCoordinatorDTO(genreObject: item))) {
                                GenreCell(model: item)
                            }
                        }
                    }
                    .padding(.bottom, 80)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear{
            self.viewModel.fetchData()
        }
    }
}

struct GenreCell: View {
    
    private var genresModel: NewGenresModel
    
    init(model: NewGenresModel) {
        self.genresModel = model
    }
    
    var body: some View {
        ZStack() {
            RoundedRectangle(cornerRadius: 8)
                .fill(LinearGradient(gradient: Gradient(colors: [Color.black, Color.hex(Constants.Colors.primaryColor)]),
                                     startPoint: .top,
                                     endPoint: .bottom))
                .frame(maxWidth: .infinity, minHeight: 100)
            
            VStack() {
                Text(genresModel.name ?? "")
                    .font(.title2)
                    .lineLimit(1)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                Group {
                    EmojiView()
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                
                Spacer()
                
            }
            .padding(15)
            
        }
        .padding(6)
    }
    
}

//struct Genres_Previews: PreviewProvider {
//    static var previews: some View {
//        GenresView(viewModel: GenresViewModel())
//            .environment(\.colorScheme, .dark)
//    }
//}





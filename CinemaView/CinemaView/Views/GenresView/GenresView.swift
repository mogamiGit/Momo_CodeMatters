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
        ZStack() {
            RoundedRectangle(cornerRadius: 8)
                .fill(LinearGradient(gradient: Gradient(colors: [Color.gray, Color.black]),
                                     startPoint: .bottom,
                                     endPoint: .top))
                .frame(maxWidth: .infinity, minHeight: 100)
            
            VStack() {
                Text(genresModel.name ?? "")
                    .font(.title3)
                    .lineLimit(1)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                Group {
                    EmojiView()
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
        
            }
            .padding(15)
            
        }
        .padding(6)
    }
}

struct Genres_Previews: PreviewProvider {
    static var previews: some View {
        GenresView(viewModel: GenresViewModel())
            .environment(\.colorScheme, .dark)
    }
}

//extension String {
//    static var randomEmoji: String {
//        let range = [UInt32](0x1F600...0x1F64F)
//        let ascii = range[Int(drand48() * (Double(range.count)))]
//        let emoji = UnicodeScalar(ascii)?.description
//        return emoji!
//    }
//}





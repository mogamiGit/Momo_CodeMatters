//
// Created on 28/1/22.
// subfolder/DetailMovieView.swift - Very brief description
//

import SwiftUI

struct DetailMovieView: View {
    
    // MARK: ObservedObject -> MVVM Dependencies
    @ObservedObject var viewModel: DetailMovieViewModel
    
    var body: some View {
        VStack{
            Text("hello world!")
                .fontWeight(.bold)
        }
        .onAppear{
            //self.viewModel.fecthDataDetail()
        }
    }
}

struct DetailMovie_Previews: PreviewProvider {
    static var previews: some View {
        DetailMovieView(viewModel: DetailMovieViewModel())
            .environment(\.colorScheme, .dark)
    }
}



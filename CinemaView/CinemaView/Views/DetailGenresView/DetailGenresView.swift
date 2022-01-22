//
// Created on 20/1/22.
// subfolder/DetailGenresView.swift - Very brief description
//

import SwiftUI

struct DetailGenresView: View {
    
    // MARK: ObservedObject -> MVVM Dependencies
    @ObservedObject var viewModel: DetailGenresViewModel
    
    var body: some View {
        VStack{
            Text("hello world!")
                .fontWeight(.bold)
        }
        .onAppear{
            
        }
    }
}

struct DetailGenres_Previews: PreviewProvider {
    static var previews: some View {
        DetailGenresView(viewModel: DetailGenresViewModel())
            .environment(\.colorScheme, .dark)
    }
}



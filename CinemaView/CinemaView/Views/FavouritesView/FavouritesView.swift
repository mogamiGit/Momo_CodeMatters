//
// Created on 3/2/22.
// subfolder/FavouritesView.swift - Very brief description
//

import SwiftUI

struct FavouritesView: View {
    
    // MARK: ObservedObject -> MVVM Dependencies
    @ObservedObject var viewModel: FavouritesViewModel
    
    var body: some View {
        VStack{
            Text("hello world!")
                .fontWeight(.bold)
        }
        .onAppear{
            
        }
    }
}

struct Favourites_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView(viewModel: FavouritesViewModel())
            .environment(\.colorScheme, .dark)
    }
}



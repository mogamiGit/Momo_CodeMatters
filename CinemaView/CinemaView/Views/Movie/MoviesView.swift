//
// Created on 26/1/22.
// subfolder/MoviesView.swift - Very brief description
//

import SwiftUI

struct MoviesView: View {
    
    // MARK: ObservedObject -> MVVM Dependencies
    @ObservedObject var viewModel: MoviesViewModel
    
    var body: some View {
        VStack{
            Text("hello world!")
                .fontWeight(.bold)
        }
        .onAppear{
            
        }
    }
}

struct Movies_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView(viewModel: MoviesViewModel())
            .environment(\.colorScheme, .dark)
    }
}



//
//  HomeView.swift
//  CinemaView
//
//  Created by Monica Galan de la Llana on 18/1/22.
//

import SwiftUI

struct HomeView: View {
    
    init() {
        UITabBar.appearance().barTintColor = UIColor.black
    }
    
    var body: some View {
        TabView {
            GenresCoordinator.navigation()
                .tabItem {
                    VStack{
                        Image(systemName: "hands.sparkles")
                        Text("Genres")
                    }
                }
            
            MoviesCoordinator.navigation()
                .tabItem {
                    VStack{
                        Image(systemName: "play.tv.fill")
                        Text("Movies")
                    }
                }
            
            FavouritesCoordinator.navigation()
                .tabItem {
                    VStack{
                        Image(systemName: "heart.rectangle.fill")
                        Text("Favorite")
                    }
                }
        }
        .accentColor(Color.hex(Constants.Colors.accentColor))
        .environment(\.colorScheme, .dark)
    }
}




//struct Home_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}


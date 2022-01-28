//
//  GenericCarouselView.swift
//  CinemaView
//
//  Created by Monica Galan de la Llana on 26/1/22.
//

import SwiftUI

struct GenericCarouselView: View {
    
    var title: String
    var colorHex: String
    var isPosterFromMoviesView: Bool
    var moviesModel: [NewMoviesModel]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            ZStack() {
                Rectangle()
                    .fill(Color.hex(colorHex).opacity(0.3))
                    .frame(width: 120, height: 15)
                    .offset(x: 20, y: 15)
                Text(title)
                    .font(.largeTitle)
                    .fontWeight(.medium)
            }
            .padding(.bottom)
            .padding(.leading)
            
            ScrollView(.horizontal, showsIndicators: false) {
                
                
                
                HStack(alignment: .top, spacing: 20) {
                    ForEach(self.moviesModel) { movie in
                        MoviePosterCell(model: movie, isPoster: self.isPosterFromMoviesView)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
    }
}

struct MoviePosterCell: View {
    
    @ObservedObject var imageLoaderVM = ImageLoader()
    private var isPoster: Bool
    private var modelData: NewMoviesModel
    
    init(model: NewMoviesModel, isPoster: Bool? = true, isRoundedRectangle: Bool? = true) {
        self.modelData = model
        self.isPoster = isPoster ?? false
        
        if isPoster ?? false {
            self.imageLoaderVM.loadImage(whit: model.posterUrl)
        } else {
            self.imageLoaderVM.loadImage(whit: model.backdropUrl)
        }
    }
    
    var body: some View {
        
        VStack () {
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
                            .fill(LinearGradient(gradient: Gradient(colors: [Color.black, Color.hex(Constants.Colors.primaryColor)]),
                                                 startPoint: .top,
                                                 endPoint: .bottom))
                            .cornerRadius(8)
                    }
                    
                }
            }
            .frame(width: self.isPoster ? 240 : 270, height: self.isPoster ? 306 : 150)
            .padding(.bottom, 15)
            .padding(.leading, self.isPoster ? 0 : 20)
            
            Text(self.modelData.name ?? "")
                .fontWeight(.medium)
                .lineLimit(1)
                .padding(.leading, self.isPoster ? 10 : 0)
                .frame(maxWidth: self.isPoster ? 180 : 200, alignment: .leading)
        }
    }
}

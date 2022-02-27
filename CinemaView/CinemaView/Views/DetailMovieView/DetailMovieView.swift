//
// Created on 28/1/22.
// subfolder/DetailMovieView.swift - Very brief description
//

import SwiftUI

struct DetailMovieView: View {
    
    // MARK: ObservedObject -> MVVM Dependencies
    @ObservedObject var viewModel: DetailMovieViewModel
    
    @SwiftUI.Environment(\.presentationMode) var presenterMode
    
    @State private var selectedTrailer: ResultVideos?
    @State var isFavorite = false
    
    private let imageLoaderVM = ImageLoader()
    
    
    var body: some View {
        ScrollView {
            VStack {
                headerImage
                
                VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        if self.viewModel.model?.genres != nil && !(self.viewModel.model?.genres?.isEmpty ?? false) {
                            GenresCarousel(model: self.viewModel.model?.genres ?? [])
                        }
                    }
                    .offset(y: -10)
                    
                    VStack(alignment: .leading, spacing: 20) {
                        
                        HStack{
                            Text(self.viewModel.model?.yearText ?? "")
                                .fontWeight(.black)
                            Text("⌇")
                            Text(self.viewModel.model?.durationText ?? "")
                        }
                        
                        Divider()
                            .background(.white)
                        
                        Text(self.viewModel.model?.title ?? "")
                            .font(.system(size: 40))
                            .fontWeight(.semibold)
                        
                        HStack{
                            if !(self.viewModel.model?.ratingText.isEmpty ?? false) {
                                Text(self.viewModel.model?.ratingText ?? "")
                                    .font(.title3)
                            }
                            
                            Text(self.viewModel.model?.scoreText ?? "")
                                .foregroundColor(Color.hex(Constants.Colors.secondaryColor))
                                .font(.title3)
                            Spacer()
                        }
                        
                        Text(self.viewModel.model?.overview ?? "")
                            .font(.title3)
                            .padding(.bottom)
                        
                        Divider()
                            .background(.white)
                        
                        Text("Starring")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            if self.viewModel.model?.cast != nil && !(self.viewModel.model?.cast?.isEmpty ?? false) {
                                CastCarousel(model: self.viewModel.model?.cast ?? [])
                            }
                        }
                        
                        Group {
                            CrewGroup(viewModel: viewModel)
                            
                            Divider()
                                .background(.white)
                            
                            YoutubeTrailers(viewModel: viewModel)
                        }
                        
                        VStack(alignment: .leading) {
                            if !self.viewModel.arrayMoviesRecommended.isEmpty {
                                GenericCarouselView(title: "Recommendations", colorHex: Constants.Colors.primaryColor, isPosterFromMoviesView: false, moviesModel: self.viewModel.arrayMoviesRecommended)
                            }
                        }
                        .padding(.bottom, 80)
                    }
                    .padding(.top)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(.black)
                }
                .offset(y: -80)
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .edgesIgnoringSafeArea(.all)
        .onAppear{
            self.viewModel.fecthDataDetail()
        }
        
    }
    
    var headerImage: some View {
        ZStack(alignment: .topLeading) {
            if self.viewModel.model?.posterUrl != nil {
                MovieDetailImage(imageURL: self.viewModel.model!.posterUrl,
                                 imageLoderVM: imageLoaderVM)
                    .listRowInsets(EdgeInsets(top: 0,
                                              leading: 20,
                                              bottom: 0,
                                              trailing: 20))
            }
            
            HStack{
                Button(action: {
                    self.presenterMode.wrappedValue.dismiss()
                }) {
                    Capsule()
                        .foregroundColor(Color.black)
                        .frame(width: 100,height: 50)
                        .overlay(Image(systemName: "chevron.left")
                                    .foregroundColor(Color.hex(Constants.Colors.accentColor))
                                    .offset(x: 20))
                    
                }
                .offset(x: -40)
                .padding(.top, 50)
                
                Spacer()
                
                Button(action: {
                    self.isFavorite.toggle()
                    self.viewModel.saveFavoriteInFirebase()
                }) {
                    Image(systemName: self.isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(Color.black)
                }
                .padding()
                .background(Color.hex(Constants.Colors.accentColor))
                .clipShape(Circle())
                .padding(EdgeInsets(top: 40,
                                    leading: 0,
                                    bottom: 0,
                                    trailing: 20))
                
            }
            .foregroundColor(.red)
        }
    }
    
}

struct MovieDetailImage: View {
    
    let imageURL: URL
    @ObservedObject var imageLoderVM: ImageLoader
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.black.opacity(0.3))
                .cornerRadius(8)
                .shadow(radius: 10)
            if self.imageLoderVM.image != nil {
                Image(uiImage: self.imageLoderVM.image!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 350, alignment: .top)
                    .cornerRadius(8)
                    .shadow(radius: 10)
            }
        }
        .onAppear {
            self.imageLoderVM.loadImage(whit: imageURL)
        }
    }
}

struct GenresCarousel: View {
    let model: [Genres]
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top, spacing: 10) {
                ForEach(self.model) { item in
                    Genrescell(model: item)
                }
            }
            .padding(.leading, 20)
        }
    }
}

struct Genrescell: View {
    
    let modelGenres: Genres
    
    init(model: Genres) {
        self.modelGenres = model
    }
    
    var body: some View {
        Text(self.modelGenres.name ?? "")
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .font(.footnote)
            .foregroundColor(.black)
            .background(Color.white.opacity(0.9))
            .cornerRadius(20)
    }
}

struct CastCarousel: View {
    
    let model: [Cast]
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top, spacing: 35) {
                ForEach(self.model) { item in
                    CastCell(model: item)
                }
            }
        }
    }
}

struct CastCell: View {
    
    let modelCast: Cast
    @ObservedObject var imageLoaderVM = ImageLoader()
    
    init(model: Cast) {
        self.modelCast = model
        self.imageLoaderVM.loadImage(whit: self.modelCast.profilePathUrl)
    }
    
    var body: some View {
        VStack{
            if self.imageLoaderVM.image != nil {
                VStack(spacing: 8) {
                    Image(uiImage: self.imageLoaderVM.image!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                    
                    Text(self.modelCast.name ?? "")
                        .font(.headline)
                        .frame(maxWidth: 100, alignment: .center)
                }
            } else {
                VStack(spacing: 8) {
                    Circle()
                        .fill(LinearGradient(gradient: Gradient(colors: [Color.hex(Constants.Colors.primaryColor), Color.clear]),
                                             startPoint: .top,
                                             endPoint: .bottom))
                        .frame(width: 120, height: 120)
                    
                    Text(self.modelCast.name ?? "")
                        .font(.headline)
                        .frame(maxWidth: 100, alignment: .center)
                }
                
            }
        }
    }
}

struct CrewGroup: View {
    
    @ObservedObject var viewModel: DetailMovieViewModel
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            if self.viewModel.model?.directors != nil && !(self.viewModel.model?.directors?.isEmpty ?? false ) {
                Text("Directors")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach((self.viewModel.model?.directors!.prefix(2))!) { item in
                            Text(item.name ?? "").font(.body)
                            Text("·")
                        }
                    }
                }
                .padding(.bottom)
            }
            
            if self.viewModel.model?.screenWriters != nil && !(self.viewModel.model?.screenWriters?.isEmpty ?? false ) {
                Text("Writters")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach((self.viewModel.model?.screenWriters!.prefix(2))!) { item in
                            Text(item.name ?? "").font(.body)
                            Text("·")
                        }
                    }
                }
                .padding(.bottom)
            }
        }
    }
}

struct YoutubeTrailers: View {
    
    @ObservedObject var viewModel: DetailMovieViewModel
    @State private var selectedTrailer: ResultVideos?
    
    var body: some View {
        
        VStack(alignment: .leading) {
            if self.viewModel.model?.youtubeTrailers != nil && !(self.viewModel.model?.youtubeTrailers?.isEmpty ?? false) {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Trailers")
                        .font(.title)
                        .fontWeight(.bold)
                    ForEach(self.viewModel.model?.youtubeTrailers!.prefix(5) ?? []) { item in
                        Button {
                            self.selectedTrailer = item
                        } label: {
                            HStack{
                                Image(systemName: "play.rectangle.fill")
                                    .foregroundColor(Color.hex(Constants.Colors.accentColor))
                                    .font(.system(size: 20))
                                    .padding(.leading, 10)
                                Text(item.name ?? "")
                                    .lineLimit(1)
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.bottom)
            }
        }
        .sheet(item: self.$selectedTrailer, content: { trailer in
            SafariView(url: trailer.youtubeURL!)
        })
    }
}




//struct DetailMovie_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailMovieView(viewModel: DetailMovieViewModel())
//            .environment(\.colorScheme, .dark)
//    }
//}



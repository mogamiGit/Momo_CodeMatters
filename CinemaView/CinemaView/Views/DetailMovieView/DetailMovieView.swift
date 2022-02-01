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
                    HStack() {
                        Spacer()
                        Text(self.viewModel.model?.genreText ?? "")
                            .padding(20)
                            .frame(minWidth: 80, maxWidth: 120, maxHeight: 40)
                            .font(.callout)
                            .foregroundColor(.black)
                            .background(Color.white.opacity(0.9))
                            .cornerRadius(20)
                            .shadow(color: Color.black.opacity(0.6), radius: 20, x: 20, y: 20)
                    }
                    .frame(maxWidth: .infinity)
                    .offset(x: -20, y: -10)
                    
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
                        
                        Spacer()
                        
                        Divider()
                            .background(.white)
                        
                        Text("Starring")
                            .font(.title)
                            .fontWeight(.bold)
                        ScrollView(.horizontal, showsIndicators: true) {
                            if self.viewModel.model?.cast != nil && !(self.viewModel.model?.cast?.isEmpty ?? false) {
                                CastCarousel(model: self.viewModel.model?.cast ?? [])
                            }
                        }
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

struct CastCarousel: View {
    
    let model: [Cast]
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView(.horizontal, showsIndicators: true) {
                HStack(alignment: .top, spacing: 35) {
                    ForEach(self.model) { item in
                        CastCell(model: item)
                    }
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




//struct DetailMovie_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailMovieView(viewModel: DetailMovieViewModel())
//            .environment(\.colorScheme, .dark)
//    }
//}



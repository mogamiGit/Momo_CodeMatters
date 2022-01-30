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
            VStack{
                headerImage
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
                .fill(Color.gray.opacity(0.3))
                .cornerRadius(8)
                .shadow(radius: 10)
            if self.imageLoderVM.image != nil {
                Image(uiImage: self.imageLoderVM.image!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(8)
                    .shadow(radius: 10)
            }
        }
        .onAppear {
            self.imageLoderVM.loadImage(whit: imageURL)
        }
    }
}

//struct DetailMovie_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailMovieView(viewModel: DetailMovieViewModel())
//            .environment(\.colorScheme, .dark)
//    }
//}



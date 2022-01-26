//
//  TitleSectionView.swift
//  CinemaView
//
//  Created by Monica Galan de la Llana on 22/1/22.
//

import SwiftUI

struct TitleSectionView: View {
    
    var title: String
    
    var body: some View {
        Text(title)
            .font(.system(size: 40))
            .fontWeight(.semibold)
            .foregroundColor(.white)
    }
}

//struct TitleSectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        TitleSectionView()
//    }
//}

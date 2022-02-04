//
//  CustomTextField.swift
//  AppTmdbCice
//
//  Created by Andres Felipe Ocampo Eljaiek on 27/11/21.
//

import SwiftUI

struct CustomTextField: View {
    
    var imageSystem: String
    var placeholder: String
    var title: String
    var text: Binding<String>
    var isSecure: Bool
    
    
    var body: some View {
        HStack{
            Spacer()
            Image(systemName: imageSystem)
                .foregroundColor(Color.black)
                .background(RoundedRectangle(cornerRadius: 30).fill(Color.hex(Constants.Colors.accentColor)).frame(width: 40, height: 40))
            ZStack(alignment: .leading) {
                Text(title)
                    .foregroundColor(Color.white)
                    .offset(y: text.wrappedValue.isEmpty ? -10 : -25)
                    .scaleEffect(text.wrappedValue.isEmpty ? 1: 0.8, anchor: .leading)
                    .padding(.top,15)
                
                if isSecure {
                    SecureField(placeholder, text: text)
                        .padding(.top,16)
                        .foregroundColor(Color.white)
                } else {
                    TextField(placeholder, text: text)
                        .padding(.top,16)
                        .foregroundColor(Color.white)
                }
               
                
            }
            .padding()
            .animation(.spring(response: 0.2, dampingFraction: 0.5))
        }
        .padding(.horizontal)
        .background(RoundedRectangle(cornerRadius: 30).fill(Color.black).frame(height: 60))
        
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            CustomTextField(imageSystem: "person", placeholder: "user", title: "user", text: .constant("user"), isSecure: true)
        }
        
    }
}



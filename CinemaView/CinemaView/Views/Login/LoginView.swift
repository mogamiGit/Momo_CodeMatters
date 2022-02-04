//
//  LoginView.swift
//  CinemaView
//
//  Created by Monica Galan de la Llana on 4/2/22.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var viewModelSession: LoginViewModel
    @State var authType: AuthType
    
    @State var email: String = ""
    @State var password: String = ""
    @State var passwordConfirmation: String = ""
    @State var showPassword = false
    
    var body: some View {
        ZStack{
            Color.hex(Constants.Colors.backgroundColor).ignoresSafeArea()
            
            VStack(){
                titleApp
                    .offset(y: 10)
                
                LottieView(name: "play-video-loader", loopMode: .loop)
                    .frame(width: 200, height: 200)
                
                if !viewModelSession.userAuth {
                    VStack(spacing: 20) {
                        CustomTextField(imageSystem: "envelope.fill", placeholder: "email",
                                        title: "email",
                                        text: self.$email, isSecure: false)
                                                
                        if showPassword {
                            CustomTextField(imageSystem: "lock.open.fill", placeholder: "password",
                                            title: "password",
                                            text: self.$password, isSecure: false)
                            
                        } else {
                            CustomTextField(imageSystem: "lock.fill", placeholder: "password",
                                                  title: "password",
                                            text: self.$password, isSecure: true)
                        }
                        
                        if authType == .register {
                            if showPassword {
                                CustomTextField(imageSystem: "questionmark", placeholder: "password confirmation",
                                                title: "password confirmation",
                                                text: self.$passwordConfirmation, isSecure: false)
                                
                            } else {
                                CustomTextField(imageSystem: "checkmark",placeholder: "password confirmation",
                                                      title: "password confirmation",
                                                text: self.$passwordConfirmation, isSecure: true)
                            }
                        }
                        
                        Toggle("Show Password", isOn: self.$showPassword)
                            .padding(10)
                            .foregroundColor(Color.gray)
                            .font(.caption)
                        
                        // Boton de login / registro
                        Button(action: {
                            self.authEmailPressDown()
                        }) {
                            Text(authType.text)
                                .lineLimit(3)
                                .font(.headline)
                        }
                        .foregroundColor(Color.gray)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color(red: 239/255, green: 243/255, blue: 244/255))
                        .cornerRadius(25)
                        
                        // change form
                        Button(action: {
                            self.buttonFooterPressDown()
                        }) {
                            Text(authType.footerText)
                                .lineLimit(3)
                                .font(.headline)
                        }
                        .foregroundColor(Color.gray)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.hex(Constants.Colors.backgroundColor))
                        .cornerRadius(25)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
    
    var titleApp: some View {
        Text("Cinema View")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundColor(Color.hex(Constants.Colors.accentColor))
        
    }
    
    private func authEmailPressDown() {
        switch authType {
        case .login:
            self.viewModelSession.access(with: .emailAndPassword(email: self.email, password: self.password))
        case .register:
            self.viewModelSession.register(email: self.email, password: self.password, passwordConfirmation: self.passwordConfirmation)
        }
    }
    
    private func buttonFooterPressDown() {
        self.cleanInputsForm()
        self.authType = authType == .register ? .login : .register
    }
    
    private func cleanInputsForm() {
        self.email = ""
        self.password = ""
        self.passwordConfirmation = ""
        self.showPassword = false
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(authType: .register)
    }
}

//
//  ContentView.swift
//  CinemaView
//
//  Created by Monica Galan de la Llana on 9/1/22.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var viewModelSession: LoginViewModel
    
    var body: some View {
        
        if self.viewModelSession.userLog != nil {
            HomeView()
        } else {
            LoginView(authType: .register)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

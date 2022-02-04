//
//  LoginViewModel.swift
//  CinemaView
//
//  Created by Monica Galan de la Llana on 4/2/22.
//

import Foundation
import FirebaseAuth

enum LoginOption {
    case inicioSesionConApple
    case emailAndPassword(email: String, password: String)
}

enum AuthType: String {
    case login
    case register
    
    var text: String {
        rawValue.capitalized
    }
    
    var footerText: String {
        switch self {
        case .login:
            return "Register to access"
        case .register:
            return "Login if yo have an account"
        }
    }
}

final class LoginViewModel: ObservableObject {
    
    @Published var userLog: User?
    @Published var changePassword: Bool?
    @Published var userAuth = false
    @Published var error: NSError?
    
    private let authenticationData = Auth.auth()
    
    required init() {
        userLog = authenticationData.currentUser
        authenticationData.addStateDidChangeListener(authModificate)
    }
    
    private func authModificate(with auth: Auth, user: User?) {
        guard user != self.userLog else { return }
        self.userLog = user
    }
    
    // Login
    func access(with loginOption: LoginOption) {
        self.userAuth = true
        self.error = nil
        switch loginOption {
        case .inicioSesionConApple:
            print("Login with Apple")
        case let .emailAndPassword(email, password):
            authenticationData.signIn(withEmail: email,
                                      password: password,
                                      completion: handlerFinishResultOfAuth)
        }
    }
    
    // Registro
    func register(email: String, password: String, passwordConfirmation: String) {
        guard password == passwordConfirmation else {
            self.error = NSError(domain: "", code: 9210, userInfo: [NSLocalizedDescriptionKey : "Password and confirmation aren't equal"])
            return
        }
        self.userAuth = true
        self.error = nil
        authenticationData.createUser(withEmail: email,
                                      password: password,
                                      completion: handlerFinishResultOfAuth)
    }
    
    // Logout
    func disconnectSession() {
        do {
            try authenticationData.signOut()
        } catch {
            self.error = NSError(domain: "", code: 9999, userInfo: [NSLocalizedDescriptionKey : "The user has failed to disconnect the session"])
        }
    }
    
    
    // Callback
    private func handlerFinishResultOfAuth(with auth: AuthDataResult?, and error: Error?) {
        DispatchQueue.main.async {
            self.userAuth = false
            if let user = auth?.user {
                self.userLog = user
            } else if let errorDes = error {
                self.error = errorDes as NSError
            }
        }
    }
}


//
//  ContentView.swift
//  Descuentos-SV
//
//  Created by edgard on 24/11/24.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage: String?
    @State private var isAuthenticated = false

    var body: some View {
        if isAuthenticated {
            MainView() // Navega a la pantalla principal si está autenticado
        } else {
            NavigationView {
                VStack(spacing: 20) {
                    Image("logoSV")
                        .resizable()
                                      
                                            
                    Text("Iniciar Sesión")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    TextField("Correo Electrónico", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10)

                    SecureField("Contraseña", text: $password)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10)

                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                    }

                    Button("Iniciar Sesión") {
                        login()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)

                    NavigationLink("¿No tienes cuenta? Regístrate aquí", destination: RegisterView(isAuthenticated: $isAuthenticated)) // Pasa la variable a RegisterView
                        .foregroundColor(.blue)
                }
                .padding()
            }
        }
    }

    private func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                errorMessage = error.localizedDescription
            } else {
                isAuthenticated = true // Cambia el estado a autenticado
                print("Inicio de sesión exitoso para: \(result?.user.email ?? "")")
            }
        }
    }
}

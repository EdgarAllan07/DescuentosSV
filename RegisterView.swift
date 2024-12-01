import SwiftUI
import FirebaseAuth

struct RegisterView: View {
    @Binding var isAuthenticated: Bool // Vincula el estado de autenticación
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage: String?

    var body: some View {
        VStack(spacing: 20) {
            Text("Crear Cuenta")
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

            Button("Registrarse") {
                register()
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)

            Spacer()
        }
        .padding()
    }

    private func register() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                errorMessage = error.localizedDescription
            } else {
                isAuthenticated = true // Cambia el estado a autenticado
                print("Usuario registrado exitosamente: \(result?.user.email ?? "")")
            }
        }
    }
}

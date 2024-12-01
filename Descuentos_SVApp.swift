import SwiftUI
import Firebase
import FirebaseAuth
@main
struct DescuentosSVApp: App {
    init()  {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
}

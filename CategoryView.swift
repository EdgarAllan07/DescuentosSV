import SwiftUI

struct CategoryView: View {
    @Binding var cart: [Product]
    let category: String

    let departments = [
        "Ropa Casual",
        "Ropa Deportiva",
        "Zapatos Casuales",
        "Accesorios",
        "Zapatos Deportivos"
    ]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Selecciona un departamento")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.horizontal)
                .padding(.top)

            ScrollView {
                LazyVGrid(
                    columns: [GridItem(.flexible()), GridItem(.flexible())],
                    spacing: 20
                ) {
                    ForEach(departments, id: \.self) { department in
                        NavigationLink(
                            destination: OffersView(
                                title: department,
                                cart: $cart,
                                category: category,
                                department: department
                            )
                        ) {
                            DepartmentCard(department: department)
                        }
                        .buttonStyle(PlainButtonStyle()) // Quita el estilo azul de los enlaces
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle(category)
        .navigationBarTitleDisplayMode(.inline)
    }
}

// Componente de tarjeta de departamento con imagen
struct DepartmentCard: View {
    let department: String

    var body: some View {
        VStack {
            Image("photito")
                .resizable()
                .scaledToFit()
                .frame(height: 80)
                .padding(.bottom, 5)

            Text(department)
                .font(.headline)
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.orange)
        .cornerRadius(15)
        .shadow(color: .gray.opacity(0.4), radius: 5, x: 0, y: 5)
    }
}

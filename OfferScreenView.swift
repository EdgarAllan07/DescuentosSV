//
//  OfferScreenView.swift
//  DescuentosSV
//
//  Created by edgard on 21/11/24.
//

import SwiftUI
import FirebaseFirestore

struct OffersView: View {
    let title: String
    @Binding var cart: [Product]
    let category: String // Hombre, Mujer, Niños
    let department: String

    let products = [
        
        // Hombres
        // Zapatos Casuales
        Product(name: "Zapato Negro Tommy", price: 59.99, imageName: "shoe1", category: "Hombre", department: "Zapatos Casuales"),
        Product(name: "Zapato Derby Café", price: 89.99, imageName: "shoe2", category: "Hombre", department: "Zapatos Casuales"),
        Product(name: "Zapato Negro Vestir", price: 89.99, imageName: "shoe3", category: "Hombre", department: "Zapatos Casuales"),
        
        // Zapatos Deportivos
        Product(name: "Zapato Adidas Concha", price: 89.99, imageName: "concha", category: "Hombre", department: "Zapatos Deportivos"),
        Product(name: "Zapato Nike Cortez", price: 69.99, imageName: "cortez", category: "Hombre", department: "Zapatos Deportivos"),
        Product(name: "Zapato New Balance", price: 49.99, imageName: "balance", category: "Hombre", department: "Zapatos Deportivos"),
        
        //Ropa Casual
        Product(name: "Camisa Tipo Polo", price: 79.99, imageName: "polohombre", category: "Hombre", department: "Ropa Casual"),
        Product(name: "Camisa Manga Larga Tommy", price: 109.99, imageName: "tommyhombre", category: "Hombre", department: "Ropa Casual"),
        
        // Ropa Deportiva
        Product(name: "Camisa Nike Seleccion", price: 25.99, imageName: "selecta", category: "Hombre", department: "Ropa Deportiva"),
        Product(name: "Short Runner Negro", price: 9.99, imageName: "runnerhombre", category: "Hombre", department: "Ropa Deportiva"),
        Product(name: "Camisa Fc Barcelona 24/25", price: 109.99, imageName: "barcelona", category: "Hombre", department: "Ropa Deportiva"),
        
        // Accesorios
        Product(name: "Reloj Bulova Hombre", price: 196.99, imageName: "relojhombre", category: "Hombre", department: "Accesorios"),
        Product(name: "Gorra casual", price: 19.99, imageName: "gorrahombre", category: "Hombre", department: "Accesorios"),
        
        // Mujeres
        Product(name: "Zapato Casual Cafe Mujer", price: 69.99, imageName: "casual1", category: "Mujer", department: "Zapatos Casuales"),
        Product(name: "Zapato Casual Rosado Mujer", price: 69.99, imageName: "casual2", category: "Mujer", department: "Zapatos Casuales"),
        Product(name: "Zapato Casual Blanco Mujer", price: 69.99, imageName: "casual3", category: "Mujer", department: "Zapatos Casuales"),
        
        // Ropa Deportiva
        Product(name: "Top Deportivo Mujer", price: 9.99, imageName: "topmujer", category: "Mujer", department: "Ropa Deportiva"),
        Product(name: "Short Deportivo Mujer", price: 29.99, imageName: "runnermujer", category: "Mujer", department: "Ropa Deportiva"),
     
        //ropa casual
        Product(name: "Vestido Casual Mujer", price: 38.99, imageName: "vestido1", category: "Mujer", department: "Ropa Casual"),
        Product(name: "Vestido Casual Mujer", price: 38.99, imageName: "vestido2", category: "Mujer", department: "Ropa Casual"),
        Product(name: "Vestido Casual Mujer", price: 38.99, imageName: "vestido3", category: "Mujer", department: "Ropa Casual"),
        
        // ninos
        Product(name: "Camisa Unisex Argentina", price: 29.99, imageName: "messininos", category: "Niños", department: "Ropa Deportiva"),
        Product(name: "Reloj para nina", price: 19.99, imageName: "relojnina", category: "Niños", department: "Accesorios"),
        Product(name: "Reloj para nino", price: 19.99, imageName: "relojnino", category: "Niños", department: "Accesorios"),
        Product(name: "Conjunto deportivo para nino", price: 19.99, imageName: "conjuntodepor", category: "Niños", department: "Ropa Deportiva"),
    ]

    var filteredProducts: [Product] {
        products.filter { $0.category == category && $0.department == department }
    }

    var body: some View {
        VStack {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)

            if filteredProducts.isEmpty {
                Text("No hay productos disponibles.")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                        ForEach(filteredProducts) { product in
                            ProductCard(product: product, onAddToCart: {
                                cart.append(product)
                            })
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("\(category) - \(department)")
    }
}
struct ProductCard: View {
    let product: Product
    var onAddToCart: () -> Void
    
    var body: some View {
        VStack {
            Image(product.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 100)
                .cornerRadius(10)
            
            Text(product.name)
                .font(.headline)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .padding(.top, 5)
            
            Text(String(format: "$%.2f", product.price))
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Button(action: onAddToCart) {
                Text("Agregar al carrito")
                    .font(.subheadline)
                    .padding(8)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top, 5)
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10)
    }
}

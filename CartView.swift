//
//  CartView.swift
//  DescuentosSV
//
//  Created by edgard on 22/11/24.
//

import SwiftUI
struct CartView: View {
    @Binding var cart: [Product]
    @State private var isProceedingToPayment = false // Estado para la navegación

    var total: Double {
        cart.reduce(0) { $0 + $1.price }
    }

    var body: some View {
        VStack {
            if cart.isEmpty {
                Text("El carrito está vacío")
                    .font(.title2)
                    .foregroundColor(.gray)
                    .padding()
            } else {
                List {
                    ForEach(cart) { product in
                        HStack {   Image(product.imageName)
                                .resizable()
                            VStack(alignment: .leading) {
                             
                                Text(product.name)
                                    .font(.headline)
                                Text("$\(String(format: "%.2f", product.price))")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            Button(action: {
                                removeFromCart(product: product)
                            }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                }
            }

            Spacer()

            // Mostrar el total
            HStack {
                Text("Total: ")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                Text("$\(String(format: "%.2f", total))")
                    .font(.title2)
                    .fontWeight(.bold)
            }
            .padding()

            // Botón para proceder al pago
            NavigationLink(
                destination: PaymentView(total: total),
                isActive: $isProceedingToPayment
            ) {
                Button(action: {
                    isProceedingToPayment = true
                }) {
                    Text("Proceder al Pago")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
        .navigationTitle("Carrito")
        .padding()
    }

    private func removeFromCart(product: Product) {
        if let index = cart.firstIndex(where: { $0.id == product.id }) {
            cart.remove(at: index)
        }
    }
}

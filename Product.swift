//
//  Product.swift
//  Descuentos-SV
//
//  Created by edgard on 24/11/24.
//
//
//  Product.swift
//  DescuentosSV
//
//  Created by edgard on 22/11/24.
//
import Foundation

struct Product: Identifiable {
    let id = UUID()
    let name: String
    let price: Double
    let imageName: String
    let category: String // Hombre, Mujer, Niños
    let department: String // Ropa Casual, Ropa Deportiva, etc.
}

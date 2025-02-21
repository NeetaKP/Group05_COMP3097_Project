//
//  ItemCostScreen.swift
//  Group05_COMP3097_Project
//
//

import SwiftUICore
import SwiftUI


struct ItemCostView: View {
    var totalCost: Double = 100.00
    var tax: Double = 10.00
    
    var body: some View {
        VStack {
            Text("Cost Summary")
                .font(.largeTitle)
                .padding()
            
            Text("Subtotal: $\(totalCost, specifier: "%.2f")")
            Text("Tax: $\(tax, specifier: "%.2f")")
            Text("Total: $\(totalCost + tax, specifier: "%.2f")")
                .font(.headline)
                .padding()
            
            Button("Confirm") {
              
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
    }
}

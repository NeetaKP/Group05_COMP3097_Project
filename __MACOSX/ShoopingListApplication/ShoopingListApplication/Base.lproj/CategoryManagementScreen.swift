//
//  CategoryManagementScreen.swift
//  Group05_COMP3097_Project
//

import SwiftUICore
import SwiftUI

struct CategoryManagementView: View {
    @State private var categories: [String] = ["Food", "Medication", "Cleaning Products"]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(categories, id: \..self) { category in
                    Text(category)
                }
            }
            .navigationTitle("Manage Categories")
            .toolbar {
                #if os(iOS)
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        
                    }) {
                        Image(systemName: "plus")
                    }
                }
                #else
                ToolbarItem {
                    Button(action: {
                    
                    }) {
                        Image(systemName: "plus")
                    }
                }
                #endif
            }
        }
    }
}


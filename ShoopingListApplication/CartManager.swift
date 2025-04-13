//
//  CartManager.swift
//  ShoopingListApplication
//
//  Created by Neeta Koirala Pant on 2025-04-09.
//

import Foundation
import CoreData
// CartManager singleton class - to hold the items selected in the cart and
//   quanitty (number) of items
class CartManager {
    static let shared = CartManager()

    private init() {}

    // Dictionary: ItemEntity -> Quantity
    private var cartItems: [ItemEntity: Int16] = [:]

    // MARK: - Add Item with Quantity
    func addItem(_ item: ItemEntity, quantity: Int16 = 1) {
        if let currentQty = cartItems[item] {
            cartItems[item] = currentQty + quantity
        } else {
            cartItems[item] = quantity
        }
    }

    // MARK: - Remove Item Completely
    func removeItem(_ item: ItemEntity) {
        cartItems.removeValue(forKey: item)
    }

    // MARK: - Set Quantity (e.g. update from picker)
    func updateQuantity(for item: ItemEntity, quantity: Int16) {
        if quantity <= 0 {
            cartItems.removeValue(forKey: item)
        } else {
            cartItems[item] = quantity
        }
    }

    // MARK: - Get All Items in Cart
    func getItems() -> [(item: ItemEntity, quantity: Int16)] {
        return cartItems.map { ($0.key, $0.value) }
    }

    // MARK: - Total Price
    func totalPrice() -> Double {
        return cartItems.reduce(0) { result, pair in
            let (item, quantity) = pair
            return result + (item.price * Double(quantity))
        }
    }

    // MARK: - Clear Cart
    func clearCart() {
        cartItems.removeAll()
    }

    // MARK: - Total Items (Qty Sum)
    func totalItemCount() -> Int16 {
        return cartItems.reduce(0) { $0 + $1.value }
    }
}

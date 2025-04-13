//
//  shoppingCartViewController.swift
//  ShoopingListApplication
//
//  Created by Neeta Koirala Pant on 2025-04-11.
//

import UIKit

class shoppingCartViewController: UIViewController {

    @IBOutlet weak var shoppintCartTableView: UITableView!
    
    @IBOutlet weak var subTotalLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var placeOrderButton: UIButton!
    var cartItems: [(item: ItemEntity, quantity: Int16)] = []
    
    //var tax: Double?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        shoppintCartTableView.delegate = self
        shoppintCartTableView.dataSource = self
        
        cartItems = CartManager.shared.getItems()
        
        self.title = "Price Summary"
        
    }
    @IBAction func placeOrderAction(_ sender: Any) {
        showAlert(message: "\u{1F60A} \u{1F60A} \u{1F60A}")
    }

}

extension shoppingCartViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.cartItems.count
    }

    
    func tableView(_ shoppintCartTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ shoppintCartTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Reuse or create a cell
        let cell = shoppintCartTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // text font styling
        cell.textLabel?.font = UIFont.systemFont(ofSize: 18)
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 14)
        cell.detailTextLabel?.textColor = .gray
        
        // Set the text label - creates item and includes in cell - one by one
        //   - displays in title (name and total price) and in subtitle (unit price and quantity)
        if cartItems.count > 0 && indexPath.section != nil {
            let total:Double = cartItems[indexPath.section].item.price * Double(cartItems[indexPath.section].quantity)
            let name:String = cartItems[indexPath.section].item.name!
            let price:Double = cartItems[indexPath.section].item.price
            let quantity: Int16 = cartItems[indexPath.section].quantity
            cell.textLabel?.text = "\(name),\t\t\t $\(floor(total*100)/100)"
            
            cell.detailTextLabel?.text = "Unit price: $\(price), Quantity: \(quantity)"
            updateSubtotalView()
            
        } else {
            cell.textLabel?.text = "Shopping cart empty"
        }

        return cell
    }
    // updates subtotal and total price in the display labels (e.g., when an item is deleted)
    func updateSubtotalView(){
        let subtotal_od = computeSubTotal();
        subTotalLabel.text = "$\(floor(subtotal_od*100)/100)"
        taxLabel.text = "$\(floor(subtotal_od*tax*100)/100) (@\(tax*100)%)"
        let total_od = subtotal_od * (1 + tax);
        totalLabel.text = "$\(floor(total_od*100)/100)"

    }
    // computes subtotal (summation of prices of all items and their counts)
    func computeSubTotal() -> Double {
        var stotal: Double = 0.0
        
        if cartItems.count > 0 {
            for (item,qty) in cartItems {
                stotal += item.price * Double(qty)
            }
        }
        return stotal
    }
    
    // shows alert message after hitting "Place Order" button
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Order placed successfully", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    // implments Delete operation for an item in shopping cart
    func tableView(_ shoppintCartTableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Remove item from data source
            CartManager.shared.removeItem(cartItems[indexPath.section].item)
            cartItems.remove(at: indexPath.section)

            // Delete the row from the table view
            shoppintCartTableView.deleteSections(IndexSet(integer: indexPath.section), with: .automatic)
            
            updateSubtotalView()
            
        }
    }
    
    // to change text of the delete button to "Remove"
    func tableView(_ shoppintCartTableView: UITableView,
                   titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Remove"
    }



}

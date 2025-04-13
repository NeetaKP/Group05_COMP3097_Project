//
//  secondViewController.swift
//  ShoopingListApplication
//
//  Created by Neeta Koirala Pant on 2025-02-19.
//

import UIKit

class secondViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var itemNameLabel: UILabel!
    
    var item:ItemEntity?;

    @IBOutlet weak var qualtityLabelView: UILabel!
    
    @IBOutlet weak var quantityTextView: UITextField!
    
    @IBOutlet weak var itemPriceLabel: UILabel!
    
    @IBOutlet weak var quantityLabel: UILabel!
    
    
    @IBOutlet weak var totalPriceView: UILabel!
    
    @IBOutlet weak var addToCartButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Enter Item Quantity"
        
        quantityTextView.delegate = self
        
        itemNameLabel?.font = UIFont.systemFont(ofSize: 18)
        quantityTextView.layer.borderWidth = 1.0
        quantityTextView.layer.borderColor = UIColor.systemBlue.cgColor
        quantityTextView.layer.cornerRadius = 8.0
        quantityTextView.clipsToBounds = true
        
        
        initialLoad()
        hideKeyboardWhenTappedAround()
    }
    
    func getTotalQuantity() -> Int16{
        validateInput()
        let totalQuantity = Int16(quantityTextView.text!) ?? 0;
        return totalQuantity
    }
    
    func getTotalPrice() -> Double  {
        let actualQuantity = getTotalQuantity()
        let total = Double(actualQuantity)*item!.price
        return total
    }
    // display item quantity and total price in the first-load - beginning
    func initialLoad(){
        itemNameLabel.text = "Item name: \(item!.name!)"
        quantityTextView.text = "0"
        qualtityLabelView.text = "Enter quantity: (max. \(item!.amount))"
        itemPriceLabel.text = "Item price: \(item!.price)"
        quantityLabel.text = "Quantity: 0"
        totalPriceView.text = "Total price: \(floor(getTotalPrice()*100)/100)"

    }

    
    // display item quantity and total price in the 2nd, 3rd, ... -loads - after the counts is selected
    func afterLoad(){
        itemNameLabel.text = "Item name: \(item?.name!  ?? "")"
        //quantityTextView.text = "0"
        qualtityLabelView.text = "Enter quantity: (max. \(item!.amount))"
                     
        itemPriceLabel.text = "Item price: \(item!.price)"
        quantityLabel.text = "Quantity: \(getTotalQuantity())"
        
        totalPriceView.text = "Total price: \(floor(getTotalPrice()*100)/100)"

    }
    // executes afterLoad function - to update selected quantity and total price
    // when user enters the quantity
    func textFieldDidEndEditing(_ textField: UITextField) {
        afterLoad()
    }

    // Logic of adding item to cart
    @IBAction func addToCartButtonAction(_ sender: Any) {
        let qty = getTotalQuantity()
        if qty > 0 && qty <= item!.amount {
            CartManager.shared.addItem(item!, quantity: getTotalQuantity())
        }
        
        let alert = UIAlertController(title: "Success", message: "\(item!.name) amount added", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
        
        
    }
    
}
// for computing and displaying item counts and total; to display item quantity and total price
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

 extension secondViewController: UITableViewDelegate, UITableViewDataSource{
 
 func numberOfSections(in tableView: UITableView) -> Int {
     return 1
 }
 
 func tableView (_ tableView: UITableView, numberOfRowsInSection section:Int)-> Int{
     return 1
 }
 
 func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
 return 8
 }
 
 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
     
     return cell
 
 }

     // validation of number of items entered in textbox
     func validateInput() {
         guard let text =
                quantityTextView.text, !text.isEmpty else {
             showAlert(message: "Please enter a number.")
             return
         }

         if let number = Int(text), number >= 0 && number <= item!.amount {
         } else {
             showAlert(message: "Please enter a positive whole number in the range (min. 0, max. \(item!.amount)).")
         }
     }

     func showAlert(message: String) {
         let alert = UIAlertController(title: "Invalid Input", message: message, preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: "OK", style: .default))
         present(alert, animated: true)
     }

 
 }
 

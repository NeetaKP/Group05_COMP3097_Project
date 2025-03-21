//
//  secondViewController.swift
//  ShoopingListApplication
//
//  Created by Neeta Koirala Pant on 2025-02-19.
//

import UIKit

class secondViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var receivedMyCart : [Item]?
    var itemName = [String]()
    var itemPrice = [Double]()
    var totalPrice: Double = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Order Summary"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        tableView.frame = CGRect(x: 10, y: 100, width: view.frame.width-20, height: 620)

        // Do any additional setup after loading the view.
        compute()
    }
    
    func compute(){
        if let mrc = receivedMyCart {
            totalPrice = 0;
            
            for item in mrc {
                itemName.append(item.name)
                itemPrice.append(item.price * Double(item.amount))
                totalPrice = totalPrice + item.price * Double(item.amount)
            }
            itemName.append("Total")
            itemPrice.append(totalPrice)
        }
        
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension secondViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.itemName.count
    }
    
    func tableView (_ tableView: UITableView, numberOfRowsInSection section:Int)-> Int{
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 3
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath)
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "Cell")! as UITableViewCell
        //guard let cell = tableView.dequeueReusableCell(withIdentifier: //"CustomCell", for: indexPath) as? CustomTableViewCell else {
            //print("Cell not found")
            //return UITableViewCell()
        //}
        print("ipr:\(self.itemName[indexPath.row])")
        cell.textLabel?.text = self.itemName[indexPath.section] + "  ----  " + String(self.itemPrice[indexPath.section])
        //cell.nameLabel.text = self.selectedItems[indexPath.section].name

        //cell.infoTextField.placeholder = "Price: \(100)"
        
        //cell.dropDownButton.tag = indexPath.row
        //cell.dropDownButton.addTarget(self, action: //#selector(dropdownTapped(_:)), for: .touchUpInside)
        
        
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath).")
    }
    
}

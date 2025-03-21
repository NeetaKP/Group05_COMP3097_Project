//
//  firstViewController.swift
//  ShoopingListApplication
//
//  Created by Neeta Koirala Pant on 2025-02-19.
//

import UIKit

class firstViewController: UIViewController {
    
    var receivedCategoryName: String?
    var receivedCellNumber: Int16?
    var itemList:[Item] = []
    var selectedItems = [Item]()
    var dropDownOptions = [Int16]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var str = "Items for Selected Category: ";
        // Do any additional setup after loading the view.
        if let data = receivedCategoryName{
            str = str + data
            print("Received: \(data)")
        }
        self.title = str;
        loadShoppingItems()
        displayShoppingItems()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        tableView.frame = CGRect(x: 10, y: 100, width: view.frame.width-20, height: 620)
        // tableView.backgroundColor = UIColor.red ///
        
        filterData()
    }
    
    func filterData(){
        for item in itemList {
            if item.category == receivedCellNumber {
                selectedItems.append(item)
                
            }
        }
    }

    @IBAction func btnTapped(_ sender: Any) {
        let  storyboard = self.storyboard?.instantiateViewController(withIdentifier: "secondViewController") as! secondViewController
              self.navigationController?.pushViewController(storyboard, animated: true)
        
    }
    
    func loadShoppingItems(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        var tempItem: Item? = Item()
        if let savedItems = appDelegate.fetchItems(context: context), !savedItems.isEmpty {
            print("Data successfully saved. Item count: \(savedItems.count)")
            
            for si in savedItems {
                    tempItem!.name = si.name ?? "<no name>>"
                    tempItem!.price = si.price
                    tempItem!.amount = si.amount
                    tempItem!.category = si.category
                itemList.append(tempItem!)
            }
            
            //for si in itemList {
            //    print("name: \(si.name), price: \(si.price), amt: \(si.amount), cat: \(si.category)")

            //}
        } else {
            print("No data found, Saving may have failed.")
        }
    }
    func displayShoppingItems(){

        if itemList != nil {
            for si in itemList {
                if si.category == receivedCellNumber {
                    print("name: \(si.name), price: \(si.price), amt: \(si.amount), cat: \(si.category)")
                }

            }
        } else {
            print("No items to shop.")
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

extension firstViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.selectedItems.count
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
        print("ipr:\(self.itemList[indexPath.row].name)")
        cell.textLabel?.text = self.selectedItems[indexPath.section].name
        //cell.nameLabel.text = self.selectedItems[indexPath.section].name

        //cell.infoTextField.placeholder = "Price: \(100)"
        
        //cell.dropDownButton.tag = indexPath.row
        //cell.dropDownButton.addTarget(self, action: //#selector(dropdownTapped(_:)), for: .touchUpInside)
        
        for i in 0...self.selectedItems[indexPath.section].amount{
            dropDownOptions.append(i)
        }
        
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        return cell
        
    }
    
    @objc func dropdownTapped(_ sender: UIButton){
        let itemIndex = sender.tag
        let alert = UIAlertController(title: "Select Option", message: nil, preferredStyle: .actionSheet)
        
        for option in dropDownOptions{
            alert.addAction(UIAlertAction(title: "\(option)", style: .default, handler: {action in sender.setTitle(action.title, for: .normal)}))
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath).")
    }
    
}

class CustomTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dropDownButton: UIButton!
    @IBOutlet weak var infoTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

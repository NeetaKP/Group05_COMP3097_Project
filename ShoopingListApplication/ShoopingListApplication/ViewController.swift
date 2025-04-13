//
//  ViewController.swift
//  ShoopingListApplication
//
//  Created by Neeta Koirala Pant on 2025-02-19.
//

import UIKit
import CoreData

struct Item {
    var name: String = ""
    var price: Double = 0.0
    var amount: Int16 = 0
    var category: Int16 = 0
}

let tax:Double = 0.13

class ViewController: UIViewController {
    
    @IBOutlet var scrollWrapView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    let spacerView = UIView()
    
    let transparentView = UIView()
    var selectedButton = UIButton()

    // button to take to view card controller
    @IBOutlet weak var btnToSummaryPage: UIButton!
        
    var datasource = [String]()
    var categoryNames:[String] = [ // used in frstViewController
        "Fruit Items",
        "Vegetable Items",
        "Grain Items",
        "Cleaning Items",
        "Medication Items",
        "Diary Items"
    ]

    var itemList:[Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        tableView.frame = CGRect(x: 10, y: 0, width: view.frame.width-20, height: 620)
        
        //seedDataSave() // used in the beginning
        
    }
    @objc func buttonTapped(_ sender: UIButton) {
        print("\(sender.currentTitle ?? "Button") tappend!")
    }
    
    // seed data saved - only used in the beginning - not used afterwards
    func seedDataSave(){
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext

            var items:[Item] = [
                Item(name: "Oranage", price: 0.99, amount:  100, category: 0),
                Item(name: "Bananas", price: 0.59, amount: 200, category: 0),
                Item(name: "Lemon", price: 0.99, amount: 100, category: 0),
                Item(name: "Mango", price: 1.0, amount: 50, category: 0),

                Item(name: "Cheese", price: 0.99, amount: 100, category: 5),
                Item(name: "Cheese", price: 2.49, amount: 25, category: 5),
                Item(name: "Milk", price: 6.22, amount: 40, category: 5),
                Item(name: "Butter", price: 0.99, amount: 100, category: 5),
                Item(name: "Yogurt", price: 0.99, amount: 100, category: 5),
            
                Item(name: "Carrot",price: 2.1, amount: 22, category: 1),
                Item(name: "Broccoli", price: 3.3, amount: 8, category: 1),
                Item(name: "Spinach", price: 2.8, amount: 12, category: 1),
                Item(name: "Cauliflower", price: 3.1, amount: 38, category: 1),
                Item(name: "Potato", price: 1.0, amount: 40, category: 1),
                
                Item(name: "Rice", price: 18.22, amount: 15, category: 2),
                Item(name: "Rice", price: 1.0, amount: 20, category: 2),
                Item(name: "Lentils", price: 2.2, amount: 15, category: 2),
                Item(name: "Oats", price: 3.2, amount: 10, category: 2),
                Item(name: "Wheat", price: 2.1, amount: 5, category: 2),

                Item(name: "Soap", price: 2.5, amount: 50, category: 3),
                Item(name: "Brush", price: 8.3, amount: 30, category: 3),
                Item(name: "Disinfectant",price: 8.8, amount: 20, category: 3),
                Item(name: "Broom", price: 10.1, amount: 5, category: 3),
                Item(name: "Sanitizer", price: 3.0, amount: 15, category: 3),

                Item(name: "Multivitamin", price: 10.0, amount: 25, category: 4),
                Item(name: "Vitamin B", price: 12.0, amount: 10, category: 4),
                Item(name: "Aspirin", price: 10.0, amount: 15, category: 4),
                Item(name: "Paracetamol", price: 6.3, amount: 40, category: 4),
                Item(name: "Mortin", price: 11.2, amount: 50, category: 4),
                ]
            //appDelegate.saveItems(items)
        }
    }
    func addTransparentView(frames: CGRect){
        let window = UIApplication.shared.keyWindow
        transparentView.frame = window?.frame ?? self.view.frame
        self.view.addSubview(transparentView)

    
        //table view
        tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y, width: frames.width, height: 0)
        
        self.view.addSubview(tableView)
        tableView.layer.cornerRadius = 5
        
        
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        tableView.reloadData()
        
        let tapgesture = UITapGestureRecognizer(target:self, action:
                        #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapgesture)
        transparentView.alpha = 0
        
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {self.transparentView.alpha = 0.5
            
            //table view
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5, width: frames.width, height: CGFloat(self.datasource.count * 50))
        }, completion: nil)   }
    
    
    @objc func removeTransparentView(){
        let frames = selectedButton.frame
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations:{ self.transparentView.alpha = 0
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        },completion: nil)
        
        
    }
    
    @IBAction func btnToSummaryPage(_ sender: Any) {
        let  storyboard = self.storyboard?.instantiateViewController(withIdentifier: "shoppingCartViewController") as! shoppingCartViewController
        self.navigationController?.pushViewController(storyboard, animated: true)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.categoryNames.count
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
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "Cell")! as UITableViewCell
        
        cell.textLabel?.text = self.categoryNames[indexPath.section]
        
        if indexPath.section % 2 == 0{
            cell.backgroundColor = UIColor.yellow
        }else{
            cell.backgroundColor = UIColor.green

        }
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
    
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
        let cat:Int16 = Int16(indexPath.section);
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let firstVC = storyboard.instantiateViewController(withIdentifier: "firstViewController") as? firstViewController {
            firstVC.selectedItems = selectItems(category: cat)
            firstVC.receivedCategoryName = self.categoryNames[indexPath.section]
            firstVC.tax = tax
            navigationController?.pushViewController(firstVC, animated: true)
        }
    }
    
    func selectItems(category cat: Int16) -> [ItemEntity] {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<ItemEntity> = ItemEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "category == %d", cat)
        
        do {
            let matchingItems = try context.fetch(fetchRequest)
            return matchingItems
        } catch {
            print("Failed to fetch items with category \(cat): \(error)")
            return []
        }
    }
}




//
//  ViewController.swift
//  ShoopingListApplication
//
//  Created by Neeta Koirala Pant on 2025-02-19.
//

import UIKit
import CoreData

class CellClass: UITableViewCell{

}

enum Category: Int16{
    case fruit = 0
    case vegetable = 1
    case grain = 2
    case cleaning = 3
    case medication = 4
    case diary = 5
}


struct Item {
    var name: String = ""
    var price: Double = 0.0
    var amount: Int16 = 0
    var category: Int16 = 0
}
// seed data


class ViewController: UIViewController {
    
    
    @IBOutlet weak var btnSelectFruit: UIButton!
    @IBOutlet weak var btnSelectMedication: UIButton!
    @IBOutlet weak var btnSelectVegetables: UIButton!
    @IBOutlet weak var btnSelectGrain: UIButton!
    @IBOutlet weak var btnSelectDiary: UIButton!    
    @IBOutlet weak var btnSelectCleaning: UIButton!
    
    @IBOutlet var scrollWrapView: UIView!
    //@IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var tableView: UITableView!
    let spacerView = UIView()
    
    @IBOutlet weak var btnToSummary: UIButton!
    let transparentView = UIView()
    //create tableview
    //let tableView = UITableView()
    var selectedButton = UIButton()
    
    @IBOutlet weak var btnToSummaryPage: UIButton!
    
    
    var datasource = [String]()
    //var categoryList = ["Orange", "Banana", "Apple","Mango", "Kiwi", "Grapes", "Kale", "Rasberry"]
    var categoryNames:[String] = [
        "Fruit Items",
        "Vegetable Items",
        "Grain Items",
        "Cleaning Items",
        "Medication Items",
        "Diary Items"
    ]

    var itemList:[Item] = []
    
    var myCart = [Item]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       // tblView.isHidden = true
        // save the seed data into persistentContainer
        

        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        
        //scrollWrapView.frame.inset(by: UIEdgeInsets(top:10, left:10, bottom: 10, right:10))
        loadShoppingItems()
        //displayShoppingItems()
        addDummyOrder();


        tableView.frame = CGRect(x: 10, y: 0, width: view.frame.width-20, height: 620)
        // sframe = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 420)
  

    /*
        for h in 0...5 {
            let button = UIButton(type: .system)
            button.setTitle("\(categoryNames[h])", for: .normal)
            button.heightAnchor.constraint(equalToConstant: 50).isActive = true
            button.backgroundColor = .systemBlue
            button.setTitleColor(.white, for: .normal)
            button.layer.cornerRadius = 8
            
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            //stackView.addArrangedSubview(button)
            
//            var k:Int = 0;
//            for i in 0...1 {
//                let button = UIButton(type: .roundedRect)
//                button.layer.backgroundColor = UIColor.lightGray.cgColor
//                button.layer.shadowOffset = CGSize(width: 10, height: 10)
//                
//                var labelText: String = ""
//                for j in k...28 {
//                    print("\(j), \(k), \(h)")
//                    if itemList[j].category == h {
//                        labelText = itemList[j].name
//                        k = j+1
//                        break
//                    }
//                }
////
//                button.setTitle("\(labelText)", for: .normal)
//                
//                stackView.addArrangedSubview(button)
    //stackView.addArrangedSubview(spacerView)
//
//                
//            }
            
        }
     */
        
        //seedDataSave()
        
    }
    
    func addDummyOrder(){
        for item in itemList {
            print("n:\(item.name), a: \(item.amount)")
            if item.name.first == "B" {
                print("ccc")
                myCart.append(item)
                myCart[myCart.count-1].amount = item.amount/3
                print("ddd")
            }
            //else {
            //    print("eee")
            //    myCart.append(Item(name:"aaa",price:22.22,amount:20,category:0))
            //}
        }
        print("size: \(myCart.count)")
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        print("\(sender.currentTitle ?? "Button") tappend!")
    }
    
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
                print("aaa")
            }
            
            for si in itemList {
                print("name: \(si.name), price: \(si.price), amt: \(si.amount), cat: \(si.category)")

            }
        } else {
            print("No data found, Saving may have failed.")
        }
    }
    func displayShoppingItems(){

        if itemList != nil {
            for si in itemList {
                print("name: \(si.name), price: \(si.price), amt: \(si.amount), cat: \(si.category)")

            }
        } else {
            print("No items to shop.")
        }
    }

    func addTransparentView(frames: CGRect){
        let window = UIApplication.shared.keyWindow
        transparentView.frame = window?.frame ?? self.view.frame
        self.view.addSubview(transparentView)

    
        //tble view
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
    
    
    @IBAction func onClickSelectFood(_ sender: Any) {
        selectedButton = btnSelectFruit
    
        datasource = ["Orange", "Banana", "Apple","Mango", "Kiwi", "Grapes", "Kale", "Rasberry"]
        addTransparentView(frames: btnSelectFruit.frame)
    }
    
    
    
    
    @IBAction func onClickSelectCleaning(_ sender: Any) {
        selectedButton = btnSelectCleaning
        datasource = ["Mr Muscle", "Detergent","Dishwashing","Toilet Brush", "Disinfectant","Floor Cleaner"]
        addTransparentView(frames: btnSelectCleaning.frame)
    }
    
    
    
    
    @IBAction func onClickSelectMedication(_ sender: Any) {
        datasource = ["Advil", "Motrin","Polysporin","Cough gel"]
        
        selectedButton = btnSelectMedication
        addTransparentView(frames: btnSelectMedication.frame)
    }
    
    
    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }
    
    @IBAction func onClickDropButton(_ sender: Any) {
       // UIView.animate(withDuration: 0.3){
            //self.tblView.isHidden = false
       // }
        
    }
    
    /*
    @IBAction func btnToSummary(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let secondVC = storyboard.instantiateViewController(withIdentifier: "secondViewController") as? secondViewController {
            self.present(secondVC, animated:true, completion: nil)
        }
//        let  storyboard = self.storyboard?.instantiateViewController(withIdentifier: "secondViewController") as! secondViewController
//        self.navigationController?.pushViewController(storyboard, animated: true)
    }
    */
    
    @IBAction func btnToSummaryPage(_ sender: Any) {
        let  storyboard = self.storyboard?.instantiateViewController(withIdentifier: "secondViewController") as! secondViewController
        print("\(myCart[0].name)")
        
            storyboard.receivedMyCart = self.myCart

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
        //let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "Cell")! as UITableViewCell
        
        cell.textLabel?.text = self.categoryNames[indexPath.section]
        
        //cell.sizeToFit()
        //cell.layoutIfNeeded()
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
        print("You tapped cell number \(indexPath.section).")
        let  storyboard = self.storyboard?.instantiateViewController(withIdentifier: "firstViewController") as! firstViewController
        storyboard.receivedCategoryName = self.categoryNames[indexPath.section]
        storyboard.receivedCellNumber = Int16(indexPath.section)
        self.navigationController?.pushViewController(storyboard, animated: true)
    }
    
}




//
//  firstViewController.swift
//  ShoopingListApplication
//
//  Created by Neeta Koirala Pant on 2025-02-19.
//

import UIKit

class firstViewController: UIViewController {
    
    var receivedCategoryName: String?
    var selectedItems:[ItemEntity]?
    var dropDownOptions = [Int16]()
    
    @IBOutlet weak var tableView: UITableView!
    
    var tax:Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var str = "";
        // Do any additional setup after loading the view.
        if let data = receivedCategoryName{
            str = str + data
        }
        self.title = str;
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        tableView.frame = CGRect(x: 10, y: 100, width: view.frame.width-20, height: 620)
    }

    @IBAction func btnTapped(_ sender: Any) {
        let  storyboard = self.storyboard?.instantiateViewController(withIdentifier: "shoppingCartViewController") as! shoppingCartViewController
        self.navigationController?.pushViewController(storyboard, animated: true)
        
    }
}

extension firstViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.selectedItems!.count
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
        cell.textLabel?.text = self.selectedItems![indexPath.section].name
        
        for i in 0...self.selectedItems![indexPath.section].amount{
            dropDownOptions.append(i)
        }
        
        if indexPath.section % 2 == 0{
            cell.backgroundColor = UIColor.yellow
        }else{
            cell.backgroundColor = UIColor.green

        }

        cell.backgroundColor = UIColor.cyan
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
        
        let selectedItem = selectedItems![indexPath.section]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let secondVC = storyboard.instantiateViewController(withIdentifier: "secondViewController") as? secondViewController {
                secondVC.item = selectedItem
                navigationController?.pushViewController(secondVC, animated: true)
        }
    }
}

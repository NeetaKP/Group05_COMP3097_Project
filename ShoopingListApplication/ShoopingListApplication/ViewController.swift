//
//  ViewController.swift
//  ShoopingListApplication
//
//  Created by Neeta Koirala Pant on 2025-02-19.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

//    @IBAction func btnTapped(_ sender: Any) {
//        let  storyboard = self.storyboard?.instantiateViewController(withIdentifier: "firstViewController") as! firstViewController
//        self.navigationController?.pushViewController(storyboard, animated: true)
//    }
// 
    
    @IBAction func btnTapped(_ sender: Any) {
        let  storyboard = self.storyboard?.instantiateViewController(withIdentifier: "firstViewController") as! firstViewController
              self.navigationController?.pushViewController(storyboard, animated: true)
    }
    
    
}


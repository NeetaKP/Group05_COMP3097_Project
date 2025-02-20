//
//  firstViewController.swift
//  ShoopingListApplication
//
//  Created by Neeta Koirala Pant on 2025-02-19.
//

import UIKit

class firstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnTapped(_ sender: Any) {
        let  storyboard = self.storyboard?.instantiateViewController(withIdentifier: "secondViewController") as! secondViewController
              self.navigationController?.pushViewController(storyboard, animated: true)
        
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

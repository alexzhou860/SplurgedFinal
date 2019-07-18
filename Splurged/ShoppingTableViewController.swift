//
//  ShoppingTableViewController.swift
//  Splurged
//
//  Created by Zhou, Alexander on 7/14/19.
//  Copyright © 2019 iOS. All rights reserved.
//

import UIKit



class ShoppingTableViewController: UITableViewController {
    
    let shoppings = ["Athletic Wear", "Shoes", "Formal", "Casual", "Jewelry", "Hats", "Watches", "Eye Wear", "Coats and Jackets", "Designer Clothes", "Swim Wear"]
  
    
    var sortedShoppings = [""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppings.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let sortedShoppings = shoppings.sorted()
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let shoppingType = sortedShoppings[indexPath.row]
        cell.textLabel!.text = shoppingType
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dvc = segue.destination as! clothesMapViewController
        let index = tableView.indexPathForSelectedRow?.row
        dvc.clothes = shoppings[index!]
    }
    
    
    
}


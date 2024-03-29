//
//  EntertainmentTableViewController.swift
//  Splurged
//
//  Created by Zhou, Alexander on 7/14/19.
//  Copyright © 2019 iOS. All rights reserved.
//

import UIKit

class EntertainmentTableViewController: UITableViewController {
    
    let entertainments = ["Movies", "Nightlife", "Music & Drama", "Parks & Rec", "Fun & Games", "Sport Events"]
    
    var sortedEntertainments = [""]
    
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
        sortedEntertainments = entertainments.sorted()
        return sortedEntertainments.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        sortedEntertainments = entertainments.sorted()
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let entertainmentType = sortedEntertainments[indexPath.row]
        cell.textLabel!.text = entertainmentType
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dvc = segue.destination as! entertainmentMapViewController
        let index = tableView.indexPathForSelectedRow?.row
        dvc.fun = sortedEntertainments[index!]
    }
    
    
}

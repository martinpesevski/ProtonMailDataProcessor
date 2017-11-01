//
//  ViewController.swift
//  ProtonMailDataProcessor
//
//  Created by Martin Peshevski on 11/1/17.
//  Copyright © 2017 MP. All rights reserved.
//

import UIKit

class DataProcessingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var pendingCompletedSegmentedControl: UISegmentedControl!
    @IBOutlet var dataTableView: UITableView!
    
    let dataItemsArray = [DataItem.init(), DataItem.init(), DataItem.init(), DataItem.init(), DataItem.init()]
    
    override func viewDidLoad() {
        super.viewDidLoad()        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "progressCellIdentifier", for: indexPath) as! ProgressCell
        
        let dataItem = dataItemsArray[indexPath.row]
        cell.setupWithDataItem(dataItem: dataItem)
        dataItem.startProcessing()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataItemsArray.count
    }
}


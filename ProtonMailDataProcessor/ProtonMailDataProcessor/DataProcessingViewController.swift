//
//  ViewController.swift
//  ProtonMailDataProcessor
//
//  Created by Martin Peshevski on 11/1/17.
//  Copyright © 2017 MP. All rights reserved.
//

import UIKit

class DataProcessingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ProgressCellDelegate {

    @IBOutlet var pendingCompletedSegmentedControl: UISegmentedControl!
    @IBOutlet var dataTableView: UITableView!
    
    var dataLoadingItemsArray = [DataItem.init(), DataItem.init(), DataItem.init(), DataItem.init(), DataItem.init()]
    var dataCompletedItemsArray : [DataItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()        
    }
    
    // MARK: tableview methods
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var dataItem : DataItem
        
        if pendingCompletedSegmentedControl.selectedSegmentIndex == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "progressCellIdentifier", for: indexPath) as! ProgressCell

            dataItem = dataLoadingItemsArray[indexPath.row]
            cell.delegate = self
            cell.setupWithDataItem(dataItem: dataItem)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "progressCompletedCellIdentifier", for: indexPath) as! ProgressCompletedCell

            dataItem = dataCompletedItemsArray[indexPath.row]
            cell.setupWithDataItem(dataItem: dataItem)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.pendingCompletedSegmentedControl.selectedSegmentIndex == 0 {
            return dataLoadingItemsArray.count
        }
        
        return dataCompletedItemsArray.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete, pendingCompletedSegmentedControl.selectedSegmentIndex == 1 {
            let dataItem = dataCompletedItemsArray[indexPath.row]
            dataItem.completed = false
            dataLoadingItemsArray.append(dataItem)
            dataCompletedItemsArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
            dataItem.startProcessing()
        }
    }
    
    // MARK: progress cell delegate
    
    func onProgressFinished(dataItem: DataItem) {
        
        guard let index = dataLoadingItemsArray.index(of: dataItem) else {
            return
        }
        
        dataCompletedItemsArray.append(dataLoadingItemsArray[index])
        dataLoadingItemsArray.remove(at: index)
        if pendingCompletedSegmentedControl.selectedSegmentIndex == 0 {
            dataTableView.deleteRows(at: [IndexPath.init(row: index, section: 0)], with: .right)
        } else {
            dataTableView.reloadData()
        }
    }
    
    // MARK: segmented control methods
    
    @IBAction func onSegmentChanged(_ sender: Any) {
        dataTableView.reloadData()
    }
}


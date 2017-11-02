//
//  ViewController.swift
//  ProtonMailDataProcessor
//
//  Created by Martin Peshevski on 11/1/17.
//  Copyright © 2017 MP. All rights reserved.
//

import UIKit
import MGSwipeTableCell

class DataProcessingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ProgressCellDelegate {

    @IBOutlet var pendingCompletedSegmentedControl: UISegmentedControl!
    @IBOutlet var dataTableView: UITableView!
    
    var dataLoadingItemsArray : [DataItem] = []
    var dataCompletedItemsArray : [DataItem] = []
    
    var editDataItem : DataItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Data Processor"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let recentlyAddedDataObject = UserDefaults.standard.object(forKey: "savedDataItem") as? NSData {
            let recentlyAddedDataItem =
                NSKeyedUnarchiver.unarchiveObject(with: recentlyAddedDataObject as Data) as! DataItem
            if !recentlyAddedDataItem.completed {
                recentlyAddedDataItem.startProcessing()
                dataLoadingItemsArray.append(recentlyAddedDataItem)
            }
            dataTableView.reloadData()
            UserDefaults.standard.removeObject(forKey: "savedDataItem")
        }
    }
    
    // MARK: tableview methods
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var dataItem : DataItem
        
        if pendingCompletedSegmentedControl.selectedSegmentIndex == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "progressCellIdentifier", for: indexPath) as! ProgressCell

            dataItem = dataLoadingItemsArray[indexPath.row]
            cell.progressCellDelegate = self
            cell.setupWithDataItem(dataItem: dataItem)
            
            //configure left buttons
            cell.leftButtons = [MGSwipeButton.init(title: "Pause", backgroundColor: .green, callback: { (swipeCell) -> Bool in
                dataItem.pauseTimer()
                return true
            })]
            cell.leftSwipeSettings.transition = .drag
            cell.leftExpansion.fillOnTrigger = false
            cell.leftExpansion.threshold = 1
            
            cell.rightButtons = [MGSwipeButton(title: "Continue", icon: nil, backgroundColor: .red, callback: { (swipeCell) -> Bool in
                dataItem.resumeTimer()
                return true
            })]
            cell.rightSwipeSettings.transition = .drag
            cell.rightExpansion.fillOnTrigger = false
            cell.rightExpansion.threshold = 1

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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if pendingCompletedSegmentedControl.selectedSegmentIndex == 0 {
            editDataItem = dataLoadingItemsArray[indexPath.row]
        } else {
            editDataItem = dataCompletedItemsArray[indexPath.row]
        }
        
        performSegue(withIdentifier: "addEditTaskSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is CreateTaskViewController {
            let destinationController = segue.destination as! CreateTaskViewController
            if let editDataItem = editDataItem {
                destinationController.dataItem = editDataItem
            }
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


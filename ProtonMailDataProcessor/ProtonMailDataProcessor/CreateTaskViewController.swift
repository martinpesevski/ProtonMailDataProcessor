//
//  CreateTaskViewController.swift
//  ProtonMailDataProcessor
//
//  Created by Martin Peshevski on 11/1/17.
//  Copyright © 2017 MP. All rights reserved.
//

import UIKit

class CreateTaskViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    @IBOutlet var nameField: UITextField!
    @IBOutlet var descriptionField: UITextField!
    @IBOutlet var keywordsTableView: UITableView!
    @IBOutlet var addFileButton: UIButton!
    
    var keywordsArray = [KeywordItem.init(keyword: "Add Keyword", isPlaceholder: true)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Create Task"

    }
    
    // MARK: tableview methods
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "keywordCellIdentifier", for: indexPath) as! KeywordCell
        
        cell.setupWithKeyword(keywordItem: keywordsArray[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return keywordsArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let keyWordItem = keywordsArray[indexPath.row]
        
        if keyWordItem.isPlaceholderForAdding {
            showAlert(text: "Add Keyword", completion: { (keyword) in
                let newKeywordItem = KeywordItem.init(keyword: keyword, isPlaceholder: false)
                self.keywordsArray.insert(newKeywordItem, at: self.keywordsArray.count - 1)
                
                self.keywordsTableView.reloadData()
            })
        }
    }
    
    func showAlert(text: String, completion: @escaping (String) -> ()) {
        let alertController = UIAlertController.init(title: text, message: "", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction.init(title: "OK", style: .default) { (_) in
            let textField = alertController.textFields![0]
            completion(textField.text!)
        }
        
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Add Keyword"
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}

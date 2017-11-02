//
//  CreateTaskViewController.swift
//  ProtonMailDataProcessor
//
//  Created by Martin Peshevski on 11/1/17.
//  Copyright © 2017 MP. All rights reserved.
//

import UIKit

class CreateTaskViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate{
    @IBOutlet var nameField: UITextField!
    @IBOutlet var descriptionField: UITextField!
    @IBOutlet var keywordsTableView: UITableView!
    @IBOutlet var addFileButton: UIButton!
    
    var keywordsArray = [KeywordItem.init(keyword: "Add Keyword", isPlaceholder: true)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Create Task"
        
        self.nameField.delegate = self
        self.descriptionField.delegate = self
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
    
    // MARK: textfield delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: alerts
    
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
    
    func showAlert(text: String, description: String?) {
        let alertController = UIAlertController.init(title: text, message: description, preferredStyle: .alert)
        
        let confirmAction = UIAlertAction.init(title: "OK", style: .cancel, handler: nil)
        
        alertController.addAction(confirmAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: IBActions
    
    @IBAction func onCancel(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onSave(_ sender: Any) {
        if nameField.text!.isEmpty {
            self.showAlert(text: "Enter a name for the task", description: nil)
            return
        }
        
        let dataItem = DataItem.init(title: nameField.text!, description: descriptionField.text, keywordsArray: keywordsArray)
        
        UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject: dataItem), forKey: "savedDataItem")
        navigationController?.popViewController(animated: true)
    }
    
}

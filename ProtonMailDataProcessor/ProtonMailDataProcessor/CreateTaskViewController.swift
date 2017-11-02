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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Create Task"

    }
    
    // MARK: tableview methods
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "keywordCellIdentifier", for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
}

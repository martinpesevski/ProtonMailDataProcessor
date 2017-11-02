//
//  doneCellTableViewCell.swift
//  ProtonMailDataProcessor
//
//  Created by Martin Peshevski on 11/2/17.
//  Copyright © 2017 MP. All rights reserved.
//

import UIKit

class ProgressCompletedCell: UITableViewCell {
    @IBOutlet var completedCellLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupWithDataItem(dataItem: DataItem) {
        completedCellLabel.text = "Task completed in: \(dataItem.totalTime)s"
    }
}

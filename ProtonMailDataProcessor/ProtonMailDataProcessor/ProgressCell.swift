//
//  ProgressCell.swift
//  ProtonMailDataProcessor
//
//  Created by Martin Peshevski on 11/1/17.
//  Copyright © 2017 MP. All rights reserved.
//

import UIKit

class ProgressCell: UITableViewCell, DataItemDelegate {
    @IBOutlet var progressView: UIProgressView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        progressView.progress = 0
    }
    
    func setupWithDataItem(dataItem:DataItem) {
        dataItem.delegate = self
    }
    
    func onProgressUpdate(progress: Double) {
        self.progressView.progress = Float(progress)
    }
}

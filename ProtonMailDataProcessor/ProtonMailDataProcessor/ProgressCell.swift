//
//  ProgressCell.swift
//  ProtonMailDataProcessor
//
//  Created by Martin Peshevski on 11/1/17.
//  Copyright © 2017 MP. All rights reserved.
//

import UIKit

protocol ProgressCellDelegate : class {
    func onProgressFinished(dataItem: DataItem)
}

class ProgressCell: UITableViewCell, DataItemDelegate {
    @IBOutlet var progressView: UIProgressView!
    
    weak var delegate : ProgressCellDelegate!
    weak var dataItem : DataItem!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.dataItem = nil
    }
    
    func setupWithDataItem(dataItem:DataItem) {
        self.dataItem = dataItem
        dataItem.delegate = self
        progressView.progress = Float(dataItem.progress) > 1 ? 1 : Float(dataItem.progress)
        if dataItem.completed {
            progressView.progressTintColor = UIColor.green
            dataItem.timer.invalidate()
        } else {
            progressView.progressTintColor = UIColor.blue
        }
    }
    
    func onProgressUpdate(progress: Double) {
        self.progressView.progress = Float(progress)
    }
    
    func onProgressFinished() {
        delegate.onProgressFinished(dataItem: dataItem)
    }
}

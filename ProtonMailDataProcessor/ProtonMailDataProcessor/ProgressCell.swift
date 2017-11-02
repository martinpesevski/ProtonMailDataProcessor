//
//  ProgressCell.swift
//  ProtonMailDataProcessor
//
//  Created by Martin Peshevski on 11/1/17.
//  Copyright © 2017 MP. All rights reserved.
//

import UIKit
import MGSwipeTableCell

protocol ProgressCellDelegate : class {
    func onProgressFinished(dataItem: DataItem)
}

public class ProgressCell: MGSwipeTableCell, DataItemDelegate {
    @IBOutlet var progressView: UIProgressView!
    
    weak var progressCellDelegate : ProgressCellDelegate!
    weak var dataItem : DataItem!
    
    public override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    public override func prepareForReuse() {
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
        progressCellDelegate.onProgressFinished(dataItem: dataItem)
    }
}

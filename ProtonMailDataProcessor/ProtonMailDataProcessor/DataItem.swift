//
//  dataItem.swift
//  ProtonMailDataProcessor
//
//  Created by Martin Peshevski on 11/1/17.
//  Copyright © 2017 MP. All rights reserved.
//

import UIKit

protocol DataItemDelegate {
    func onProgressUpdate(progress: Double)
}

class DataItem: NSObject {
    var timer : Timer = Timer()
    let totalTime : Double = Double(arc4random_uniform(10)) + 1 //to avoid zero
    var endDate : Date = Date()
    var timerProgress = 0.0
    let timerInterval = 0.5
    var progress : Double {
        return timerProgress / totalTime
    }
    var delegate : DataItemDelegate!
    
    override init() {
        super.init()
    }
    
    func startProcessing() {
        var timesRun : Int = 0
        self.timer = Timer.init(timeInterval: 0.5, repeats: true, block: { (blockTimer) in
            timesRun = timesRun + 1
            self.timerProgress = Double(timesRun) * self.timerInterval
            if self.progress > 1 {
                blockTimer.invalidate()
            } else {
                self.delegate.onProgressUpdate(progress: self.progress)
            }
        })
        RunLoop.current.add(self.timer, forMode: .defaultRunLoopMode)
    }
}

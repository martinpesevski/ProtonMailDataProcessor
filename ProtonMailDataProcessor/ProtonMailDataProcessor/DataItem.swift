//
//  dataItem.swift
//  ProtonMailDataProcessor
//
//  Created by Martin Peshevski on 11/1/17.
//  Copyright © 2017 MP. All rights reserved.
//

import UIKit

protocol DataItemDelegate : class {
    func onProgressUpdate(progress: Double)
    func onProgressFinished()
}

class DataItem: NSObject {
    var timer : Timer = Timer()
    let totalTime : Double = Double(arc4random_uniform(10)) + 1 //to avoid zero
//    let totalTime = 5.0
    var timerProgress = 0.0
    let timerInterval = 0.01
    var completed = false
    
    var progress : Double {
        return timerProgress / totalTime
    }
    weak var delegate : DataItemDelegate!
    
    override init() {
        super.init()
        
        startProcessing()
    }
    
    func startProcessing() {
        if completed {
            return
        }
        
        timerProgress = 0.0
        var timesRun : Int = 0
        self.timer = Timer.init(timeInterval: timerInterval, repeats: true, block: { (blockTimer) in
            timesRun = timesRun + 1
            self.timerProgress = Double(timesRun) * self.timerInterval
            guard let delegate = self.delegate else {
                return
            }
            if self.progress > 1 {
                self.completed = true
                blockTimer.invalidate()
                DispatchQueue.main.async {
                    delegate.onProgressFinished()
                }
            } else {
                DispatchQueue.main.async {
                    delegate.onProgressUpdate(progress: self.progress)
                }
            }
        })
        RunLoop.current.add(self.timer, forMode: .defaultRunLoopMode)
    }
}

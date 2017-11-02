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

class DataItem: NSObject, NSCoding {
    var timer : Timer = Timer()
    let totalTime : Double = Double(arc4random_uniform(100)) + 1 //to avoid zero
    var timerProgress = 0.0
    let timerInterval = 0.01
    var completed = false
    var keywordsArray : [KeywordItem]?
    var title : String!
    var dataDescription: String?
    
    var progress : Double {
        return timerProgress / totalTime
    }
    weak var delegate : DataItemDelegate!
    
    init(title: String, description: String?, keywordsArray: [KeywordItem]?) {
        super.init()
                
        self.title = title
        self.dataDescription = description
        self.keywordsArray = keywordsArray
        
        startProcessing()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.title = aDecoder.decodeObject(forKey: "dataItemTitle") as! String
        self.dataDescription = aDecoder.decodeObject(forKey: "dataDescription") as? String ?? ""
        self.keywordsArray = aDecoder.decodeObject(forKey: "keywordsArray") as? [KeywordItem] ?? []
        
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.title, forKey: "dataItemTitle")
        aCoder.encode(self.dataDescription, forKey: "dataDescription")
        aCoder.encode(self.keywordsArray, forKey: "keywordsArray")
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

//
//  KeywordItem.swift
//  ProtonMailDataProcessor
//
//  Created by Martin Peshevski on 11/2/17.
//  Copyright © 2017 MP. All rights reserved.
//

import UIKit

class KeywordItem: NSObject, NSCoding {
    var keyword = ""
    var isPlaceholderForAdding = false
    
    init(keyword: String, isPlaceholder: Bool) {
        super.init()
        
        self.keyword = keyword
        isPlaceholderForAdding = isPlaceholder
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.keyword = aDecoder.decodeObject(forKey: "keyword") as! String
        
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(keyword, forKey: "keyword")
    }
}

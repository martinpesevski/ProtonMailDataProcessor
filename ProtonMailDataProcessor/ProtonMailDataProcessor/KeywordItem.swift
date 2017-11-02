//
//  KeywordItem.swift
//  ProtonMailDataProcessor
//
//  Created by Martin Peshevski on 11/2/17.
//  Copyright © 2017 MP. All rights reserved.
//

import UIKit

class KeywordItem: NSObject {
    var keyword = ""
    var isPlaceholderForAdding = false
    
    init(keyword: String, isPlaceholder: Bool) {
        super.init()
        
        self.keyword = keyword
        isPlaceholderForAdding = isPlaceholder
    }
}

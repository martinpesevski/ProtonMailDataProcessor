//
//  KeywordCell.swift
//  ProtonMailDataProcessor
//
//  Created by Martin Peshevski on 11/2/17.
//  Copyright © 2017 MP. All rights reserved.
//

import UIKit

class KeywordCell: UITableViewCell {
    @IBOutlet var keywordImageView: UIImageView!
    @IBOutlet var keywordLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupWithKeyword(keywordItem: KeywordItem) {
        keywordLabel.text = keywordItem.keyword
        
        if keywordItem.isPlaceholderForAdding {
            imageView?.image = UIImage.init(named: "add_icon")?.withRenderingMode(.alwaysTemplate)
            imageView?.tintColor = UIColor.green
        } else {
            imageView?.image = UIImage.init(named: "remove_icon")?.withRenderingMode(.alwaysTemplate)
            imageView?.tintColor = UIColor.red
        }
    }
}

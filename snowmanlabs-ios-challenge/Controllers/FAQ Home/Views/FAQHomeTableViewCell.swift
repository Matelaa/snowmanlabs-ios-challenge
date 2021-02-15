//
//  FAQHomeTableViewCell.swift
//  snowmanlabs-ios-challenge
//
//  Created by José Matela Neto on 15/02/21.
//

import UIKit

class FAQHomeTableViewCell: UITableViewCell {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    required override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
    }
}

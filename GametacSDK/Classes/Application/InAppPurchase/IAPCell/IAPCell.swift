//
//  IAPCell.swift
//  TestHero
//
//  Created by Linh Phan on 11/14/19.
//  Copyright © 2019 Linh Phan. All rights reserved.
//

import UIKit
import StoreKit

class IAPCell: UITableViewCell {
    
    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var lblItemPrice: UILabel!
    
    var product: SKProduct? {
        didSet {
            guard let product = product else { return }
            
            lblItemName?.text = product.localizedTitle
            lblItemPrice?.text = IAPCell.priceFormatter.string(from: product.price)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    static let priceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        
        formatter.formatterBehavior = .behavior10_4
        formatter.numberStyle = .currency
        
        return formatter
    }()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//
//  NotiCell.swift
//  AppsFlyer
//
//  Created by Linh Phan on 10/2/19.
//  Copyright © 2019 Linh Phan. All rights reserved.
//

import UIKit

class NotiCell: UITableViewCell {
    
    @IBOutlet weak var lblNotiName: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

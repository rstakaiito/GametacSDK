//
//  PhotoSelectedCell.swift
//  AppCloud
//
//  Created by Linh Phan on 9/10/19.
//  Copyright © 2019 Linh Phan. All rights reserved.
//

import UIKit

class PhotoSelectedCell: UICollectionViewCell {
    
    @IBOutlet weak var imgSelected: UIImageView!
    @IBOutlet weak var viewShadow: UIView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        viewShadow.addShadowForCell()
    }

}

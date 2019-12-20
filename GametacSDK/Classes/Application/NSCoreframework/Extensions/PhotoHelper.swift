//
//  PhotoHelper.swift
//  Mobi Caro
//
//  Created by Phan Hải Linh on 12/14/18.
//  Copyright © 2018 Kien Nguyen Duc. All rights reserved.
//

import Foundation
import UIKit

class PhotoHelper: NSObject {
    static func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(newWidth, newHeight))
        image.draw(in: CGRect(0, 0, newWidth, newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}

//
//  AlertHelper.swift
//  CeoIntegration
//
//  Created by Kien Nguyen Duc on 4/5/18.
//  Copyright © 2018 newsoft. All rights reserved.
//

import UIKit

class AlertHelper: NSObject {
    static func alert(title:String? = "",content:String,btnTitle:String? = "Ok")->UIAlertController{
        let alert = UIAlertController(title: title, message: content,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { _ in
        }))
        return alert
    }
}

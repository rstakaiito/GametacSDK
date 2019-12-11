//
//  SDKServices.swift
//  AppsFlyer
//
//  Created by Kien Nguyen Duc on 11/29/19.
//  Copyright © 2019 Linh Phan. All rights reserved.
//

import UIKit
import Foundation


class GametacSDK: NSObject {
    class var sharedInstance: GametacSDK {
        struct Singleton {
            static let instance = GametacSDK()
        }
        return Singleton.instance
    }
    
    
    var client_secret = "hUkYHxRk4wtS8gIQBePHuvPX3IfrgkOvw3Z8M1NH"
    var client_id = 5
    

}

//
//  PurchaseService.swift
//  TestHero
//
//  Created by Kien Nguyen Duc on 11/25/19.
//  Copyright © 2019 Linh Phan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class IAPService: NSObject {
    
    class var sharedInstance: IAPService {
        struct Singleton {
            static let instance = IAPService()
        }
        return Singleton.instance
    }
    
    
    var server_id:Int?
    var player_id:Int?
    var extra_data:String?
    var client_id:Int?

    var product_ids = [String]()
    
    func configData(client_id:Int, server_id:Int, player_id:Int, extra_data:String){
        self.client_id = client_id
        self.server_id = server_id
        self.player_id = player_id
        self.extra_data = extra_data
    }
    
    
    
    var receiptData = ""
}

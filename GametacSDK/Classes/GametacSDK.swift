//
//  SDKServices.swift
//  AppsFlyer
//
//  Created by Kien Nguyen Duc on 11/29/19.
//  Copyright © 2019 Linh Phan. All rights reserved.
//

import UIKit
import Foundation
import GoogleSignIn

class GametacSDK: NSObject {
    class var sharedInstance: GametacSDK {
        struct Singleton {
            static let instance = GametacSDK()
        }
        return Singleton.instance
    }
    
    
    var client_secret = "hUkYHxRk4wtS8gIQBePHuvPX3IfrgkOvw3Z8M1NH"
    var client_id = 5
    var gid = ""
    
    public func config(clientID:Int, clientSecret:String){
        self.client_id = clientID
        self.client_secret = clientSecret
    }

    public func showLoginDialog(_ presentVC:UIViewController, _ isClose: @escaping((Bool)->Void)){
        
        let loginVCImplement = LoginVC()
        
        let navControllerSDK = UINavigationController.init(rootViewController: loginVCImplement)
        
        loginVCImplement.didCloseDialog = { cl in
            navControllerSDK.dismiss(animated: true) {
                isClose(cl)
            }
        }
        GIDSignIn.sharedInstance().presentingViewController = presentVC
        presentVC.present(navControllerSDK, animated: true, completion: nil)
        
        
    }
    
    public func logOut(){
        
    }
    
    func sendReceiptToServer(receiptData:String,completion:@escaping(MessageStruct)->()){
    }
    
    public func getLoginedInfo()->UserStruct{
        return NSAuthentication.sharedInstance.profile
    }
     
}

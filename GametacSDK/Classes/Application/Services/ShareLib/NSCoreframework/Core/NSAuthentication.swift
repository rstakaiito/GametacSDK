//
//  NSAuthentication.swift
//  MobiHair Customer
//
//  Created by Duong Viet Cuong on 11/3/17.
//  Copyright © 2017 newsoft. All rights reserved.
//

import UIKit


enum RefreshTokenState {
    case Success
    case Failed
}
class NSAuthentication: NSObject {
    
    class var sharedInstance: NSAuthentication {
        struct Singleton {
            static let instance = NSAuthentication()
        }
        return Singleton.instance
    }

    

        
    
    
    func getToken()-> String {
        let token = UserDefaults.standard.object(forKey: "access_token") as? String
        return token == nil ? "" : token!
    }
    
    func getRefreshToken()-> String {
        let token = UserDefaults.standard.object(forKey: "refresh_token") as? String
        return token == nil ? "" : token!
    }
    
    
    var profile: UserStruct{
        set(user){
            let userDefults = UserDefaults.standard
            userDefults.set((user.accessToken), forKey: "access_token")
            userDefults.set((user.refreshToken), forKey: "refresh_token")
            userDefults.synchronize()
        }
        get{
            let userDefaults = UserDefaults.standard
            var u = UserStruct()
           
            if let val = userDefaults.value(forKey: "access_token"){
                u.accessToken = val as! String
            }
            if let val = userDefaults.value(forKey: "refresh_token"){
                u.refreshToken = val as! String
            }
            
            return u
        }
    }
    

    /**
    *   Logout authentication
    */
    func logout(){
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(nil, forKey: "token")
        userDefaults.synchronize()
        
    }

}

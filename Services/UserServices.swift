//
//  UserServices.swift
//  AppsFlyer
//
//  Created by Linh Phan on 10/1/19.
//  Copyright © 2019 Linh Phan. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class UserServices: NSObject {
    class var sharedInstance: UserServices {
        struct Singleton {
            static let instance = UserServices()
        }
        return Singleton.instance
    }
    //duhsdhus
    
    let kAPIRegistry = "https://api.vntac.vn/v1/auth/register"
    let kAPILogin = "https://api.vntac.vn/v1/auth/login"
    let kAPILoginSocial = "https://api.vntac.vn/v1/auth/login-socialite"
    let kAPIGetUserInfo = "https://api.vntac.vn/v1/auth/user"
    let kAPIChangeProfileUser = "https://api.vntac.vn/v1/auth/change-information"
    let kAPIPlayWithoutLogin = "https://api.vntac.vn/v1/auth/login-device"
    let kAPISwitchToActiveAccount = "https://api.vntac.vn/v1/auth/set-device-account"
    let kAPIRefreshToken = "https://api.vntac.vn/v1/auth/refresh-token"
    
    
    func refreshToken(completion:@escaping(MessageStruct, UserStruct)->()){
        let param:[String:Any] = ["refresh_token":NSAuthentication.sharedInstance.getRefreshToken(),
                                  "client_id": SDKServices.sharedInstance.client_id,
                                  "client_secret":SDKServices.sharedInstance.client_secret]
        
        NSNetRequest.sharedInstance.post(url: self.kAPIRefreshToken, param: param, userToken: false) { (json, msg) in
            debugPrint(json)
            var user:UserStruct = appDelegate().infoLogined
            user.tokenType = json["data"]["auth"]["token_type"].stringValue
            user.accessToken = json["data"]["auth"]["access_token"].stringValue
            user.refreshToken = json["data"]["auth"]["refresh_token"].stringValue
            completion(msg,user)
        }
    }
    
    func switchToActiveAccount(name: String,
                               email: String,
                               password: String,
                               password_confirmation: String,
                               completion:@escaping(MessageStruct, UserStruct)->()){
        NSNetRequest.sharedInstance.postWithHeader(url: self.kAPISwitchToActiveAccount, param: ["name" : name,
                                                                                                "email":email,
                                                                                                "password":password,
                                                                                                "password_confirmation":password_confirmation], userToken: false) { (json, msg) in
                                                                                                    debugPrint(json)
                                                                                                    completion(msg, self.parseJSONToUserStruct(json: json))
        }
    }
    
    func changeInfomation(fullName: String,
                          birthday: String,
                          gender: Int,
                          phone: String,
                          new_password: String,
                          new_password_confirmation: String,
                          password:String,
                          completion:@escaping(MessageStruct, UserStruct)->()){
        NSNetRequest.sharedInstance.postWithHeader(url: self.kAPIChangeProfileUser, param: ["fullName" : fullName,
                                                                                            "birthday":birthday,
                                                                                            "gender":gender,
                                                                                            "phone":phone,
                                                                                            "new_password":new_password,
                                                                                            "new_password_confirmation":new_password_confirmation,
                                                                                            "password":password], userToken: false) { (json, msg) in
                                                                                                debugPrint(json)
                                                                                                
                                                                                                
                                                                                                completion(msg, self.parseJSONToUserStruct(json: json))
        }
    }
    
    
    
    func getUserInfo(completion:@escaping(MessageStruct, UserStruct)->()){
        
        NSNetRequest.sharedInstance.postWithHeader(url: self.kAPIGetUserInfo, param: ["client_id":SDKServices.sharedInstance.client_id], userToken: false) { (json, msg) in
            debugPrint(json)
            
            completion(msg, self.parseJSONToUserStruct(json: json))
        }
    }
    
    func playWithoutLogin(device_id: String,
                          client_id: Int,
                          client_secret: String,
                          completion:@escaping(MessageStruct, UserStruct)->()){
        NSNetRequest.sharedInstance.post(url: self.kAPIPlayWithoutLogin, param: ["device_id" : device_id,
                                                                                 "client_id":client_id,
                                                                                 "client_secret":client_secret], userToken: false) { (json, msg) in
                                                                                    debugPrint(json)
                                                                                    var user = UserStruct()
                                                                                    
                                                                                    
                                                                                    completion(msg, self.parseJSONToUserStruct(json: json))
        }
    }
    
    func login(login: String,
               password: String,
               client_id:Int,
               client_secret: String,
               completion:@escaping(MessageStruct, UserStruct)->()){
        NSNetRequest.sharedInstance.post(url: self.kAPILogin, param: ["login" : login,
                                                                      "password":password,
                                                                      "client_id":client_id,
                                                                      "client_secret":client_secret], userToken: false) { (json, msg) in
                                                                        debugPrint(json)
                                                                        
                                                                        
                                                                        completion(msg, self.parseJSONToUserStruct(json: json))
        }
    }
    
    
    func registry(name: String,
                  email: String,
                  password: String,
                  password_confirmation: String,
                  fullName: String,
                  client_id:Int,
                  client_secret: String, completion:@escaping(MessageStruct)->()){
        NSNetRequest.sharedInstance.post(url: self.kAPIRegistry, param: ["name" : name,
                                                                         "email": email,
                                                                         "password":password,
                                                                         "password_confirmation":password_confirmation,
                                                                         "full_name":fullName,
                                                                         "client_id":client_id,
                                                                         "client_secret":client_secret], userToken: false) { (json, msg) in
                                                                            debugPrint(json)
                                                                            completion(msg)
        }
    }
    
    
    func loginSocial(token: String, provider:String, client_id:Int, client_secret: String, completion:@escaping(MessageStruct, UserStruct)->()){
        NSNetRequest.sharedInstance.post(url: self.kAPILoginSocial, param: ["token" : token,
                                                                            "provider":provider,
                                                                            "client_id":client_id,
                                                                            "client_secret":client_secret], userToken: false) { (json, msg) in
                                                                                debugPrint(json)
                                                                                completion(msg, self.parseJSONToUserStruct(json: json))
        }
    }
    
    func parseJSONToUserStruct(json: JSON) -> UserStruct{
        var user = UserStruct()
        user.id = json["data"]["user"]["id"].intValue
        user.name = json["data"]["user"]["name"].stringValue
        user.email = json["data"]["user"]["email"].stringValue
        user.coin = json["data"]["user"]["coin"].stringValue
        user.fullName = json["data"]["user"]["full_name"].stringValue
        user.avatar = json["data"]["user"]["avatar"].stringValue
        user.provider = json["data"]["user"]["provider"].stringValue
        user.active = json["data"]["user"]["active"].intValue
        user.email_verified_at = json["data"]["user"]["email_verified_at"].stringValue
        user.address = json["data"]["user"]["address"].stringValue
        user.phone = json["data"]["user"]["phone"].stringValue
        user.birthday = json["data"]["user"]["birthday"].stringValue
        user.gender = json["data"]["user"]["gender"].intValue
        user.national_id = json["data"]["user"]["national_id"].stringValue
        user.national_id_issued_date = json["data"]["user"]["national_id_issued_date"].stringValue
        user.national_id_issued_location = json["data"]["user"]["national_id_issued_location"].stringValue
        
        user.tokenType = json["data"]["auth"]["token_type"].stringValue
        user.accessToken = json["data"]["auth"]["access_token"].stringValue
        user.refreshToken = json["data"]["auth"]["refresh_token"].stringValue
        return user
    }
    
}

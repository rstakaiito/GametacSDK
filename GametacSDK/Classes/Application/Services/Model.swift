//
//  Model.swift
//  AppsFlyer
//
//  Created by Linh Phan on 10/1/19.
//  Copyright © 2019 Linh Phan. All rights reserved.
//

import Foundation
import UIKit


public struct UserStruct{
    var id:Int!
    var name:String = ""
    var email:String = ""
    var coin: String = ""
    var fullName:String = ""
    var provider: String = ""
    var active: Int!
    var email_verified_at: String = ""
    var address: String = ""
    var birthday: String = ""
    var gender:Int = 1
    var national_id: String = ""
    var national_id_issued_date: String = ""
    var national_id_issued_location: String = ""
    var avatar: String = ""
    var phone:String = ""
    

    
    //Token
    var tokenType = ""
    var accessToken = ""
    var refreshToken = ""
    var tokenExpiresIn = 0
    
}


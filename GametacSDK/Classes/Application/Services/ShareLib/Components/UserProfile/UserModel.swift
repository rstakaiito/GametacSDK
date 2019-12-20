////
////  UserModel.swift
////  Mobihair Employee
////
////  Created by Duong Viet Cuong on 11/15/17.
////  Copyright © 2017 newsoft. All rights reserved.
////
//
//import UIKit
//
//struct ReportEarnFinanceStruct {
//    var cuoctaixe: Int?
//    var cuocgioithieu: Int?
//    var gioithieu: Int?
//    var taichinh: Int?
////    init(cuoctaixe:Int,cuocgioithieu:Int,gioithieu:Int,taichinh:Int) {
////        self.cuoctaixe = cuoctaixe
////        self.cuocgioithieu = cuocgioithieu
////        self.gioithieu = gioithieu
////        self.taichinh = taichinh
////    }
//}
//
//struct TransactionByUserStruct {
//    var tag:String = ""
//    var walletID:String = ""
////    var userID:String = ""
//    var refuId: Int = 0
//    var content: String = ""
//    var time: String = ""
//    var id: Int = 0
//    var different: Int = 0
////    var userTitle: String = ""
////    var userAvatar: String = ""
//    var cashOnTime: Int = 0
//    var withUser = UserMocaStruct()
//}
////struct MemberCountStruct {
////    var count: Int?
////}
//
//struct CountMemberStruct{
//    var count: Int?
//}
//
//struct QuestionStruct{
//    var id: Int?
//    var title: String?
//}
//
//struct MonthNowStruct {
//    var cuoctaixe: Int?
//    var cuocgioithieu: Int?
//    var gioithieu: Int?
//    var taichinh: Int?
//}
//
//struct ListTotalStruct {
//    var month:String?
//    var money:Int?
//    var m:Int?
//    var y:Int?
//}
//
//struct SelectCarStruct {
//    var title: String?
//    var image: UIImage?
//    var price: Int?
//    var distance:Int?
//    init() {}
//    init(title:String,image: UIImage,price:Int,distance:Int) {
//        self.title =  title
//        self.image = image
//        self.price = price
//        self.distance = distance
//    }
//}
//
//struct ServicesStruct {
//    var id: Int
//    var image: UIImage
//    var title:String
//    init(id: Int, image: UIImage, title:String) {
//        self.id = id
//        self.image = image
//        self.title = title
//    }
//}
//
//
//
//struct TransactionHistoryStruct {
//    
//    var time: String?
//    var value: String
//    var content: String?
//    var id: Int?
//    var withUser: UserStruct?
//    
//    init(time:String, value: String, content: String) {
//        self.time = time
//        self.value = value
//        self.content = content
//    }
//}
//
//struct TransactionMoneyStruct {
//    var money: Int?
//    var totalMoney: Int?
//    var fee: Int?
//    var note:String?
//    init(money: Int,totalMoney: Int,fee: Int) {
//        self.money = money
//        self.totalMoney = totalMoney
//        self.fee = fee
//    }
//}
//
//struct UserModel{
//    var id :Int = 0
//    var title : String = ""
//    var avatar : String = ""
//}
//
//
//struct BankStruct {
//    var title:String?
//    var id: Int?
//    var code: String?
//    var imageURL:String?
//    var cost: String?
//    var accBankNumber: String?
//    
//    init() {
//    }
//    init(id:Int,title:String,code: String,imageURL: String) {
//        self.title = title
//        self.id = id
//        self.code = code
//        self.imageURL = imageURL
//    }
//}
//
//struct WalletStruct {
//    var title: String = ""
//    var balance:Int = 0
//    var id: Int = 0
//    var coin:String = ""
//    init(title:String, balance:Int, id: Int, coin: String) {
//        self.title = title
//        self.balance = balance
//        self.id = id
//        self.coin = coin
//    }
//    init() {}
//    
//}
//
//struct UserStruct {
//
//    var lat: Double!
//    var long: Double!
//    var sex: String?
//    var content:String!
//    var id : Int!
//    var refCode:String = ""
//    var requestId: Int!
//    var company: String!
//    var title : String!
//    var phone : String!
//    var email : String!
//    var type : String!
//    var token : String!
//    var avatarURL:String?
//    var rankContent: String!
//    var address: String?
//    var accuracy: String?
//    var status: Int?
//    var coverURL:String?
//
//    var transactionPassword: Bool = false
//    init(){
//    }
//    init(id: Int, title:String) {
//        self.id = id
//        self.title = title
//    }
//    // Set role with string input
//
//    init(id: Int, title:String, rankContent: String) {
//        self.id = id
//        self.title = title
//        self.rankContent = rankContent
//    }
//    init(id : Int , title : String , phone : String , email : String ) {
//        self.id = id
//        self.title = title
//        self.phone = phone
//        self.email = email
//    }
//
//    init(id : Int , title : String , phone : String , email : String , type : String) {
//        self.id = id
//        self.title = title
//        self.phone = phone
//        self.email = email
//        self.type = type
//    }
//    init(id : Int , title : String , phone : String , email : String , token : String) {
//        self.id = id
//        self.title = title
//        self.phone = phone
//        self.email = email
//        self.token = token
//    }
//    init(id : Int , title : String , phone : String , email : String , type : String, token : String) {
//        self.id = id
//        self.title = title
//        self.phone = phone
//        self.email = email
//        self.type = type
//        self.token = token
//    }
//    init(id : Int , title : String , avatarURL : String , status : Int) {
//        self.id = id
//        self.title = title
//        self.avatarURL = avatarURL
//        self.status = status
//    }
//}
//
//struct UserStructCV{
//    //    var productCount: Int!
//    var transactionPassword: Bool = false
//    var content:String!
//    var id : Int!
//    var requestId: Int!
//    var company: String!
//    var title : String!
//    var phone : String!
//    var email : String!
//    var type : String!
//    var token : String!
//    var avatarURL:String?
//    var rankContent: String!
//    var address: String?
//    var numFollowing: Int?
//    var numFollower: Int!
//    var numProduct:Int?
//    var accuracy: String?
//    var status: Int?
//    var coverURL:String?
//    
//    // Version 2.0 Upgrade to enum full namespace
////    var role: UserRole?
//    
//    init(){
//    }
//    
//    init(id : Int , title : String){
//        self.id = id
//        self.title = title
//    }
//    
//    init(id: Int, title:String, rankContent: String) {
//        self.id = id
//        self.title = title
//        self.rankContent = rankContent
//    }
//    
//    init(id : Int , title : String , numFollowing : Int , numFollower : Int , numProduct : Int,accuracy:String) {
//        self.id = id
//        self.title = title
//        self.numFollowing = numFollowing
//        self.numFollower = numFollower
//        self.numProduct = numProduct
//        self.accuracy = accuracy
//    }
//    
//    init(id : Int , title : String , phone : String , email : String , type : String) {
//        self.id = id
//        self.title = title
//        self.phone = phone
//        self.email = email
//        self.type = type
//    }
////    // Set role with string input
////    mutating func setRoleString(_ input:String){
////        if(input.elementsEqual("ceo")){
////            self.role = .CEO
////        }
////        if(input.elementsEqual("manager")){
////            self.role = .Manager
////        }
////        if(input.elementsEqual("customer")){
////            self.role = .Customer
////        }
////    }
//    init(id : Int , title : String , phone : String , email : String , type : String, token : String) {
//        self.id = id
//        self.title = title
//        self.phone = phone
//        self.email = email
//        self.token = token
//        self.type = type
//    }
//    init(id : Int , title : String , avatarURL : String , status : Int) {
//        self.id = id
//        self.title = title
//        self.avatarURL = avatarURL
//        self.status = status
//    }
//}
//

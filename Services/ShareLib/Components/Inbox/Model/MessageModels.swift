////
////  MessageModels.swift
////  MobiCaro
////
////  Created by Phan Hải Linh on 12/7/18.
////  Copyright © 2018 Kien Nguyen Duc. All rights reserved.
////
//
//import UIKit
//
//struct ConversationTopicStruct{
//    var id:String = ""
//    var title:String = ""
//    var content:String = ""
//    var time:Date = Date()
//    var sender:UserModel = UserModel()
//}
//
//struct ConversationStruct {
//    var id: Int!
//    var sender:UserMocaStruct!
//    var content: String!
//    var time: String!
//    var seen: Int!
//    init(id: Int, sender: UserMocaStruct, content: String, time: String, seen: Int) {
//        self.id = id
//        self.sender = sender
//        self.content = content
//        self.time = time
//        self.seen = seen
//    }
//}
//
//struct Message{
//    
//    var id : String!
//    var time : String!
//    var senderId : String!
//    var senderTitle : String!
//    var recipientId : String!
//    var recipientTitle : String!
//    var content : String!
//    
//    
//    init(id : String , time : String , senderId : String , senderTitle : String) {
//        self.id = id
//        self.time = time
//        self.senderId = senderId
//        self.senderTitle = senderTitle
//    }
//    
//    init(id : String , time : String , senderId : String , senderTitle : String ,recipientId : String , recipientTitle : String , content : String) {
//        self.id = id
//        self.time = time
//        self.senderId = senderId
//        self.senderTitle = senderTitle
//        self.recipientId = recipientId
//        self.recipientTitle = recipientTitle
//        self.content = content
//    }
//    
//}
//

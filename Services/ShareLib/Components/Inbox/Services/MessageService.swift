////
////  MessageService.swift
////  MobiCaro
////
////  Created by Phan Hải Linh on 12/7/18.
////  Copyright © 2018 Kien Nguyen Duc. All rights reserved.
////
//
//import UIKit
//import Alamofire
//import SwiftyJSON
////import JSQMessagesViewController
////import MessageKit
//
///*
// ver1.0
// */
//class MessageService: NSObject {
//    
//    
//    
//    let kAPIInbox = "api/message/inbox"
//    let kAPISend  = "api/message/send_message"
//    let kAPIConv  = "api/message/conversation"
//    let kAPIGetMessage = "api/message/get_message"
//    let kAPIGetAllMessages = "api/message/get_all_message"
//    
//    fileprivate var messages : [MockMessage] = []
//    
//    var indexResponse : String = String()
//    
//    class var sharedInstance: MessageService {
//        struct Singleton {
//            static let instance = MessageService()
//        }
//        return Singleton.instance
//    }
//    
//    func getAllMessage(userId: Int,kw: String, index: Int,completion:@escaping (MessageStruct,[ConversationStruct],Int) -> ()){
//        NSNetRequest.sharedInstance.post(url: self.kAPIGetAllMessages, param: ["userid":userId,
//                                                                               "kw" : kw,
//                                                                               "index" : index], userToken: true) { (json, msg) in
//                                                                                print(json)
//                                                                                let index = json["index"].intValue
//                                                                                var arrTopic = [ConversationStruct]()
//                                                                                for jsonData in json["data"].arrayValue {
//                                                                                    let sender = UserMocaStruct(id: jsonData["user"]["id"].intValue, title: jsonData["user"]["title"].stringValue, avatarURL: jsonData["user"]["avatar"].stringValue, phone: jsonData["user"]["phone"].stringValue)
//                                                                                    let topic = ConversationStruct(id: jsonData["id"].intValue, sender: sender, content: jsonData["msg"].stringValue, time: jsonData["time"].stringValue, seen: jsonData["read"].intValue)
//                                                                                    arrTopic.append(topic)
//                                                                                }
//                                                                                completion(msg,arrTopic,index)
//        }
//    }
//    
//    func sendMessage(content: String, userID: Int,completion:@escaping (MessageStruct) -> ()){
//        NSNetRequest.sharedInstance.post(url: self.kAPISend, param: ["msg" : content,
//                                                                     "userid" : userID], userToken: true) { (json, err) in
//                                                                        print(json)
//                                                                        completion(err)
//        }
//    }
//    
//    func getMessage(userID:Int, index:Int,completion:@escaping (MessageStruct,[MockMessage],Int) -> ()){
//        NSNetRequest
//            .sharedInstance
//            .post(url: self.kAPIGetMessage, param: ["userid" : userID,
//                                                    "index" : index], userToken: true) { (json, msg) in
//                                                        debugPrint(json)
//                                                        let jsonResponse = json["data"].arrayValue
//                                                        var arrayMessage = [MockMessage]()
//                                                        for jsonM in jsonResponse {
//                                                            let sender = Sender(id: jsonM["from"].intValue.description, displayName: jsonM["from_account"]["title"].stringValue)
//                                                            let message = MockMessage(text: jsonM["content"].stringValue, sender: sender, messageId: "", date: Date.init())
//                                                            arrayMessage.append(message)
////                                                            let sender = UserMocaStruct(id: jsonM["from"].intValue, title: jsonM["from_account"]["title"].stringValue, avatarURL: jsonM["from_account"]["avatar"].stringValue, phone: jsonM["from_account"]["phone"].stringValue)
////                                                            let message = JSQMessage(senderId: String(sender.id), displayName: sender.title, text: jsonM["content"].stringValue)
////                                                            arrayMessage.append(message!)
//                                                        }
//                                                        let index = json["index"].intValue
//                                                        completion(msg,arrayMessage,index)
//                                                        
//        }
//        
//    }
//    
//    
//    // MARK: LIST my inbox
//    func inbox(lastIndex : String, completion:@escaping (MessageStruct,_ lastIndex : String,[ConversationTopicStruct]) -> ())  {
//        var messages = [ConversationTopicStruct]()
//        NSNetRequest
//            .sharedInstance
//            .post(url: kAPIInbox, param: ["index" : lastIndex],
//                  userToken: true) { (json, error) in
//                    if(error.error){
//                        completion(error, "", messages)
//                        return
//                    }
//                    for jsonResponse in json["items"].arrayValue {
//                        let sender = UserModel(id: jsonResponse["sender_id"].intValue,
//                                               title: jsonResponse["sender_title"].stringValue,
//                                               avatar: jsonResponse["sender_avatar"].stringValue)
//                        let e = ConversationTopicStruct.init(id: jsonResponse["index"].stringValue,
//                                                             title: jsonResponse["sender_title"].stringValue,
//                                                             content: jsonResponse["sender_content"].stringValue,
//                                                             time: Date.init(timeIntervalSince1970: jsonResponse["time"].doubleValue),
//                                                             sender: sender)
//                        messages.append(e)
//                    }
//                    completion(error, json["last_index"].stringValue, messages)
//        }
//    }
//    
//    // MARK: API Detail conversation with conversation ID
//    func conversation(last_index:String,conversationID:String,completion:@escaping (MessageStruct,_ last_index:String,[Message]) -> ()){
//        var messages = [Message]()
//        NSNetRequest
//            .sharedInstance
//            .post(url: kAPIConv, param: ["last_index" : last_index,
//                                         "conversation" : conversationID],
//                  userToken: true) { (json, error) in
//                    
//                    if(error.error){
//                        completion(error, "",  messages)
//                        return
//                    }
//                    
//                    for jsonResponse in json["items"].arrayValue {
//                        let no = Message(
//                            id : jsonResponse["index"].stringValue,
//                            time : jsonResponse["time"].stringValue,
//                            senderId: jsonResponse["sender_id"].stringValue,
//                            senderTitle : jsonResponse["sender_title"].stringValue,
//                            recipientId : jsonResponse["recipient_id"].stringValue,
//                            recipientTitle : jsonResponse["recipient_title"].stringValue,
//                            content : jsonResponse["content"].stringValue
//                            
//                        )
//                        messages.append(no)
//                    }
//                    completion(error, json["last_index"].stringValue, messages)
//        }
//    }
//    
//    // MARK: Send message to conversation
//    func send(content:String,recipientId : Int,completion:@escaping (MessageStruct) -> ()){
//        NSNetRequest
//            .sharedInstance
//            .post(url: kAPISend,
//                  param: ["content":content,"recipient_id":recipientId],
//                  userToken: true) { (json, error) in
//                    completion(error)
//        }
//    }
//}
//

import UIKit
import SwiftyJSON

class NotificationService: NSObject {
    
    let kAPINotificationURL = "api/notice/fetch"
    let kAPIRegistryDeviceID = "api/user/update_token_device"
    let kAPINotificationUpdateTouch = "api/notice/update_touch"

    class var sharedInstance: NotificationService {
        struct Singleton {
            static let instance = NotificationService()
        }
        return Singleton.instance
    }
    
    
    func updateTouch(id:String,completion:@escaping (MessageStruct) -> ())  {
        NSNetRequest.sharedInstance.post(url: kAPINotificationUpdateTouch, param: ["id":id],
                                         userToken: true) { (json, error) in
                                            completion(error);
        }
    }
    
    func list(i_index : Int, completion:@escaping (
        MessageStruct,
        _ indexResponse :
        String,[NotificationStruct]) -> ())  {
        var items = [NotificationStruct]()
        NSNetRequest
            .sharedInstance
            .post(url: kAPINotificationURL ,
                  param: ["begin" : i_index],
                  userToken: true) { (json, error) in
                    if(!error.error){
                        for jsonResponse in json["items"].arrayValue {
                            let el = NotificationStruct(id: jsonResponse["id"].stringValue,
                                                        time: jsonResponse["time"].stringValue.dateFromISOString(),
                                                        content: jsonResponse["present"]["caption"].stringValue,
                                                        icon: jsonResponse["present"].stringValue,
                                                        imageURL: jsonResponse["present"]["photo"].stringValue,
                                                        /*metaJSON: "",*/
                                                        readed:jsonResponse["readed"].boolValue,
                                                        touched:jsonResponse["touched"].boolValue
                            )
                            items.append(el)
                        }
                    }
                    completion(error, "0", items)
        }
    }
    
    func registryDevice(deviceID:String, deviceInfo:String,completion:@escaping(MessageStruct)->()){
        NSNetRequest.sharedInstance
            .post(url: kAPIRegistryDeviceID,
                  param: ["device_id" : deviceID,
                          "type" : "ios",
                          "information":deviceInfo], userToken: true) { (json, error) in
                            completion(error);
        }
    }
}

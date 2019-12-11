import UIKit
import SwiftyJSON

struct NotificationStruct{
    
    var id : String!    // MongoDB ID
    var time : Date!
    var content : String!
    var icon : String!
    var imageURL:String!
//    var metaJSON : [JSON]?
    var readed:Bool = false
    var touched:Bool = false
}

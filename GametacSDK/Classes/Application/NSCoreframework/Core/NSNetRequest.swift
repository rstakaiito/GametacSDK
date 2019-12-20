import UIKit
import Alamofire
import SwiftyJSON

enum NSPOST_URLREquestConventible: URLRequestConvertible {
    

    static var baseURLPath = ""

    case postData(String,String)
    case getData(String,String)
    
    var method: HTTPMethod {
        switch self {
        case .postData:
            return .post
        case .getData:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .postData(let url, _):
            return url
        case .getData(let url, _):
            return url
        }
    }
    public func asURLRequest() throws -> URLRequest {
        
        let parameters: String = {
            switch self {
            case .postData( _ ,let param):
                return param
            default:
                return ""
            }
            
        }()
        
        let url = try NSPOST_URLREquestConventible.baseURLPath.asURL()
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        request.timeoutInterval = TimeInterval(10 * 1000)
        request.setValue("application/json", forHTTPHeaderField:"Accept")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type")
        let encoding = Alamofire.JSONEncoding.default
        
        return try encoding.encode(request, withJSONObject: parameters.toJSON())
        //.encode(request, with: parameters.toJSON())
    }
    
}

class NSNetRequest:NSObject{
    
    static var baseURLPath = ""

//    let kAPIUploadEndpoint = "api/upload/temp"
    let kAPIUploadEndpoint = "id.appcloud-dev.com/api/user/auth/updateAvatar"
    
    // Singleton
    class var sharedInstance: NSNetRequest {
        struct Singleton {
            static let instance = NSNetRequest()
        }
        return Singleton.instance
    }
    
    func uploadPhoto(imageArr:[UIImage],jsonReturn:@escaping([String],MessageStruct)->()){
        var data = [String:Any]()
        data["token"] = NSAuthentication.sharedInstance.getToken()
        Alamofire.upload(multipartFormData: { multipartFormData in
            if(imageArr.count > 0){
                for index in 0..<imageArr.count{
                    let imageData = imageArr[index].jpegData(compressionQuality: 1)
                    multipartFormData.append(imageData!, withName: "f[\(index + 1)]", fileName: "file\(index).png", mimeType: "image/jpeg")
                }
            }
            for (key, value) in data {
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }}, to: "\(NSNetRequest.baseURLPath)" + "\(kAPIUploadEndpoint)"
            , method: .post,
              encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        print("====Server response===")
                        debugPrint(response)
                        let json = JSON(response.value ?? "")
                        print("errors",json)
                        let errorService = MessageStruct(
                            error :json["error"].boolValue,
                            message : json["msg"].stringValue
                        )
                        var keyImagePath = [String]()
                        if(!errorService.error){
                            // Not error
                            for i in json["files"].arrayValue{
                                keyImagePath.append(i.stringValue)
                            }
                        }
                        jsonReturn(keyImagePath, errorService)
                    }
                case .failure(let _): break
                    
                    
                }
        })
    }
    
    func postWithPhoto(url:String,
                       param:[String:Any],
                       userToken:Bool,
                       image:UIImage,jsonReturn:@escaping(JSON,MessageStruct)->()){
        var data = param
        if userToken {
            data["token"] = NSAuthentication.sharedInstance.getToken()
        }
        print(data)
        //  Do upload file alamofire
        Alamofire.upload(multipartFormData: { multipartFormData in
            for (key, value) in data {
                if value is String || value is Int {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
                }
            }
            let imageData = image.jpegData(compressionQuality: 0.5)
            multipartFormData.append(imageData!, withName: "file", fileName: "file.jpeg", mimeType: "image/jpeg")
        }, to: NSNetRequest.baseURLPath.appending(url), method: .post,
           
           encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    debugPrint(response)
                    if let value = response.value{
                        let json = JSON(value)
                        print("errors",json)
                        let errorService = MessageStruct(
                            error :json["error"].boolValue,
                            message : json["msg"].stringValue
                        )
                        jsonReturn(json, errorService)
                    }
                }
            case .failure(let encodingError): break
            print(encodingResult)
            }
        })
        
    }
    
    
    func postWithPhotos(url:String,
                        param:[String:Any],
                        userToken:Bool,
                        imageArr:[UIImage],jsonReturn:@escaping(JSON,MessageStruct)->()){
        var data = param
        if userToken {
            data["token"] = NSAuthentication.sharedInstance.getToken()
        }
        print(data)
        Alamofire.upload(multipartFormData: { multipartFormData in
            for (key, value) in data {
                if value is String || value is Int {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
                }
                
            }
            if(imageArr.count > 0){
                for index in 0..<imageArr.count{
                    let imageData = imageArr[index].jpegData(compressionQuality: 0.5)
                    multipartFormData.append(imageData!, withName: "file[]", fileName: "file\(index).jpeg", mimeType: "image/jpeg")
                }
            }
        }, to: NSNetRequest.baseURLPath.appending(url), method: .post,
           encodingCompletion: { encodingResult in
            
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    debugPrint(response)
                    if let value = response.value{
                        
                        let json = JSON(value)
                        print("errors",json)
                        let errorService = MessageStruct(
                            error :json["error"].boolValue,
                            message : json["msg"].stringValue
                        )
                        jsonReturn(json, errorService)
                    }
                }
            case .failure(let encodingError): break
            print(encodingResult)
            }
        })
        
    }
    
    
    func postUpdataProfile(url:String,
                         param:[String:Any],
                         userToken:Bool,
                         imgCMND: UIImage,
                         imgAvatar:UIImage,
                         jsonReturn:@escaping(JSON,MessageStruct)->()){
        var data = param
        if userToken {
             data["token"] = NSAuthentication.sharedInstance.getToken()
        }
        
        //  Do upload file alamofire
        Alamofire.upload(multipartFormData: { multipartFormData in
            for (key, value) in data {
                if value is String || value is Int {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
                }
            }
            
            let imgDataCMND = imgCMND.jpegData(compressionQuality: 0.5)
            let imgDataAvatar = imgAvatar.jpegData(compressionQuality: 0.5)
            
            
            multipartFormData.append(imgDataCMND!, withName: "filecmnd", fileName: "cmnd.jpeg", mimeType: "image/jpeg")
            multipartFormData.append(imgDataAvatar!, withName: "fileavatar", fileName: "avatar.jpeg", mimeType: "image/jpeg")
            
            
        }, to: NSNetRequest.baseURLPath.appending(url), method: .post,
           
           encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    debugPrint(response)
                    if let value = response.value{
                        let json = JSON(value)
                        print("errors",json)
                        let errorService = MessageStruct(
                            error :json["error"].boolValue,
                            message : json["msg"].stringValue
                        )
                        jsonReturn(json, errorService)
                    }
                }
            case .failure(let encodingError):
            print(encodingResult)
            let msg = MessageStruct(error: true, message: "Có vấn đề trong quá trình kết nối")
//            LoadingHelper.ShowTopMessage(content: msg.msg, type: LoadingHelperType.error)
            }
        })
        
    }

    
    func post(url:String,param:[String:Any],userToken:Bool,jsonReturn:@escaping(JSON,MessageStruct)->()){
        var data = param
        if (userToken){
            data["token"] = NSAuthentication.sharedInstance.getToken()
        }
        
        let url = NSNetRequest.baseURLPath.appending(url)
        print("\(url) : Sending \(data)")
        Alamofire.request(url,
                          method: .post, parameters: data,
                          encoding: URLEncoding.default,
                          headers: nil).responseJSON{ response in
                            print("\(url) : Response" )
                            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                                print("\(url) : Data \n \(utf8Text)")
                            }
                            switch response.result {
                            case .success(let value):
                                let json = JSON(value)
                                let errorService = MessageStruct(error: json["error"].boolValue, message: json["message"].stringValue, code: json["code"].intValue)
                                
                                jsonReturn(json,errorService)
                            case .failure(let _):
                                print("\(url) : Response error!" )
                                let json:JSON = [:]
                                let msg = MessageStruct(error: true, message: "Có vấn đề trong quá trình kết nối",code: 1010)

                                jsonReturn(json,msg)
                            }
        }
    }
    
    func postWithHeader(url:String,param:[String:Any],userToken:Bool,jsonReturn:@escaping(JSON,MessageStruct)->()){
        var data = param
        if (userToken){
            data["token"] = NSAuthentication.sharedInstance.getToken()
        }
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(NSAuthentication.sharedInstance.getToken())",
            "Accept": "application/json"
        ]
        
        let url = NSNetRequest.baseURLPath.appending(url)
        print("\(url) : Sending \(data)")
        Alamofire.request(url,
                          method: .post, parameters: data,
                          encoding: URLEncoding.default,
                          headers: headers).responseJSON{ response in
                            print("\(url) : Response" )
                            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                                print("\(url) : Data \n \(utf8Text)")
                            }
                            switch response.result {
                            case .success(let value):
                                let json = JSON(value)
                                let errorService = MessageStruct(error: json["error"].boolValue, message: json["message"].stringValue, code: json["code"].intValue)
                                jsonReturn(json,errorService)
                            case .failure(let _):
                                print("\(url) : Response error!" )
                                let json:JSON = [:]
                                let msg = MessageStruct(error: true, message: "Có vấn đề trong quá trình kết nối",code: 1010)
                                //                                LoadingHelper.ShowTopMessage(content: msg.msg, type: LoadingHelperType.error)
                                jsonReturn(json,msg)
                            }
        }
    }
    
    
    func postNoneMessage(url:String,param:[String:Any],userToken:Bool,jsonReturn:@escaping(JSON,MessageStruct)->()){
        var data = param
        if (userToken){
            data["token"] = NSAuthentication.sharedInstance.getToken()
        }
        let url = NSNetRequest.baseURLPath.appending(url)
        print("\(url) : Sending \(data)")
        Alamofire.request(url,
                          method: .post, parameters: data,
                          encoding: URLEncoding.default,
                          headers: nil).responseJSON{ response in
                            print("\(url) : Response" )
                            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                                print("\(url) : Data \n \(utf8Text)")
                            }
                            switch response.result {
                            case .success(let value):
                                let json = JSON(value)
                                let errorService = MessageStruct(error: json["error"].boolValue, message: json["msg"].stringValue, code: json["code"].intValue)
                                jsonReturn(json,errorService)
                            case .failure(let _):
                                print("\(url) : Response error!" )
                                let json:JSON = [:]
                                let msg = MessageStruct(error: true, message: "Có vấn đề trong quá trình kết nối",code: 0)
//                                LoadingHelper.ShowTopMessage(content: msg.msg, type: LoadingHelperType.error)
                                jsonReturn(json,msg)
                            }
        }
    }
    
    
    
    func postLog(url:String,param:[String:Any],userToken:Bool,jsonReturn:@escaping(JSON,MessageStruct)->()){
        var data = param
        if (userToken){
            data["token"] = NSAuthentication.sharedInstance.getToken()
        }
        let url = "http://fl.appcloud.vn/"+"\(url)"
        print("\(url) : Sending \(data)")
        Alamofire.request(url,
                          method: .post, parameters: data,
                          encoding: URLEncoding.default,
                          headers: nil).responseJSON{ response in
                            print("\(url) : Response" )
                            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                                print("\(url) : Data \n \(utf8Text)")
                            }
                            switch response.result {
                            case .success(let value):
                                let json = JSON(value)
                                let errorService = MessageStruct(error: json["error"].boolValue, message: json["msg"].stringValue, code: json["code"].intValue)
                                jsonReturn(json,errorService)
                            case .failure(let _):
                                print("\(url) : Response error!" )
                                let json:JSON = [:]
                                let msg = MessageStruct(error: true, message: "Có vấn đề trong quá trình kết nối",code: 1010)
                                //                                LoadingHelper.ShowTopMessage(content: msg.msg, type: LoadingHelperType.error)
                                jsonReturn(json,msg)
                            }
        }
    }
    
}



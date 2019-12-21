//
//  MyHelper.swift
//  iTower
//
//  Created by Nguyen Thanh Tung on 4/14/17.
//  Copyright © 2017 Nguyen Thanh Tung. All rights reserved.
//

import UIKit
import SystemConfiguration

struct MessageStruct{
    var code: Int = 0
    var error : Bool = false
    var message : String = ""
    
    init(error : Bool , message : String){
        self.error = error
        self.message = message
    }
    
    init(error : Bool , message : String,code: Int ){
        self.error = error
        self.message = message
        self.code = code
    }

}


class MyHelper: NSObject {
    
    class var sharedInstance: MyHelper {
        struct Singleton {
            static let instance = MyHelper()
        }
        return Singleton.instance
    }

    func showAlertNotification(msg : String){
        let alertController = UIAlertController (title: "Thông báo", message: msg, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Đồng ý", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
        
    }
    
    
    func isInternetAvailable() -> Bool {
        guard let flags = getFlags() else { return false }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
    
    func getFlags() -> SCNetworkReachabilityFlags? {
        guard let reachability = ipv4Reachability() ?? ipv6Reachability() else {
            return nil
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(reachability, &flags) {
            return nil
        }
        return flags
    }
    
    func ipv6Reachability() -> SCNetworkReachability? {
        var zeroAddress = sockaddr_in6()
        zeroAddress.sin6_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin6_family = sa_family_t(AF_INET6)
        
        return withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        })
    }
    
    func ipv4Reachability() -> SCNetworkReachability? {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        return withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        })
    }
    
    
    
}

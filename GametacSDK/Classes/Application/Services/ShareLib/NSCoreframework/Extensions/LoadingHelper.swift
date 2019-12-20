//
//  LoadingHelper.swift
//  CeoIntegration
//
//  Created by Duong Viet Cuong on 7/28/18.
//  Copyright © 2018 newsoft. All rights reserved.
//


//import UIKit
//import SwiftMessages
//
//public enum LoadingHelperType{
//    case info
//    case success
//    case warning
//    case error
//}
//
//class LoadingHelper: NSObject {
//    static func Indicator(show:Bool){
//        
//    }
//    
//    static func ShowTopMessage(content:String,type:LoadingHelperType = LoadingHelperType.info){
//        let view = MessageView.viewFromNib(layout: .statusLine)
//        view.configureContent(body: content)
//        switch type {
//        case .info:
//            view.configureTheme(.info)
//        case .error:
//            view.configureTheme(.error)
//        case .success:
//            view.configureTheme(.success)
//        case .warning:
//            view.configureTheme(.warning)
//        }
//        SwiftMessages.show(view: view)
//    }
//    
//    static func HideTopMessage(){
//        SwiftMessages.hide()
//    }
//    
//}

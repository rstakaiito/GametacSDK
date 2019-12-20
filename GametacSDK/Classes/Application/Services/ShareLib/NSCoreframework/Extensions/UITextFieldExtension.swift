////
////  UITextFieldExtension.swift
////  iTower
////
////  Created by Nguyen Thanh Tung on 4/17/17.
////  Copyright © 2017 Nguyen Thanh Tung. All rights reserved.
////
//
//import UIKit
//
//class TextFieldExtension: UITextField {
//    
//    
//    @IBInspectable var paddingLeft: CGFloat = 0
//    @IBInspectable var paddingRight: CGFloat = 0
//    
//    override func textRect(forBounds bounds: CGRect) -> CGRect {
//        return CGRect(bounds.origin.x + paddingLeft, bounds.origin.y,
//                      bounds.size.width - paddingLeft - paddingRight, bounds.size.height);
//    }
//    
//    override func editingRect(forBounds bounds: CGRect) -> CGRect {
//        return textRect(forBounds: bounds)
//    }
//    
//    
//    
//}
// 

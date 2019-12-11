//
//  IntExtension.swift
//  CeoIntegration
//
//  Created by Duong Viet Cuong on 2/28/18.
//  Copyright © 2018 newsoft. All rights reserved.
//

import UIKit

extension Double{
    func toString() -> String {
        return "\(self)"
    }
    
    func concurencyFormat(_ format:String? = "%.02f") -> String {
        return String(format: "%.02f", self)
    }
    
    
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension Int {

    
    
    func toPointFormat(balance:Int,leftDotSize:CGFloat = 32, rightDotSize:CGFloat = 20,textColor:UIColor = #colorLiteral(red: 0.1665761173, green: 0.5024254322, blue: 0.7700731754, alpha: 1),font:String = "iCielPanton-Light") -> NSMutableAttributedString{
        
        let attrs1 = [NSAttributedString.Key.font : UIFont(name: font, size: leftDotSize), NSAttributedString.Key.foregroundColor : textColor]
        let attrs2 = [NSAttributedString.Key.font : UIFont(name: font, size: rightDotSize), NSAttributedString.Key.foregroundColor : textColor]
    
        let value = (Float(balance)/1000)
        let arrBalanceElement = value.description.components(separatedBy: ".")
        debugPrint(arrBalanceElement)
        
        let leftDot = NSMutableAttributedString(string:"\(Int(arrBalanceElement[0])!.formattedWithSeparator)", attributes:attrs1)
        let rightDot = NSMutableAttributedString(string:"\(arrBalanceElement[1])", attributes:attrs2)
        let dot = NSMutableAttributedString(string:".", attributes:attrs2)
        let point = NSMutableAttributedString(string:" Point", attributes:attrs1)
        
        let labelText = NSMutableAttributedString()
        labelText.append(leftDot)
        labelText.append(dot)
        labelText.append(rightDot)
        labelText.append(point)
        return labelText
    }
    

    func toPointFormatWithSign(balance:Int) -> NSMutableAttributedString{
        let textColor:UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        let attrs1 = [NSAttributedString.Key.font : UIFont(name: "Avenir Next", size: 12), NSAttributedString.Key.foregroundColor : textColor]
        let attrs2 = [NSAttributedString.Key.font : UIFont(name: "Avenir Next", size: 10), NSAttributedString.Key.foregroundColor : textColor]
        
        var sign = NSMutableAttributedString()
        if balance >= 0 {
            sign = NSMutableAttributedString(string:"+", attributes: attrs1)
        } else {
            debugPrint("Balance: \(balance)")
            if balance < 0 && balance > -1000 {
                sign = NSMutableAttributedString(string:"-", attributes: attrs1)
            } else {
                sign = NSMutableAttributedString(string:"", attributes: attrs1)
            }
        }
        
        
        let value = (Float(balance)/1000)
        let arrBalanceElement = value.description.components(separatedBy: ".")
        
        
        
        let leftDot = NSMutableAttributedString(string:"\(Int(arrBalanceElement[0])!.formattedWithSeparator)", attributes:attrs1)
        
        debugPrint(arrBalanceElement)
        debugPrint("sign: \(sign.string)")
        debugPrint("leftdot: \(Int(arrBalanceElement[0])!.formattedWithSeparator)")
        
        let rightDot = NSMutableAttributedString(string:"\(arrBalanceElement[1])", attributes:attrs2)
        let dot = NSMutableAttributedString(string:".", attributes:attrs2)
        let point = NSMutableAttributedString(string:" Point", attributes:attrs1)
        
        let labelText = NSMutableAttributedString()
        labelText.append(sign)
        labelText.append(leftDot)
        labelText.append(dot)
        labelText.append(rightDot)
        labelText.append(point)
        return labelText
    }
    
    var roundedWithAbbreviations: String {
        let number = Double(self)
        let thousand = number / 1000
        let million = number / 1000000
        if million >= 1.0 {
            return "\(round(million*10)/10)M"
        }
        else if thousand >= 1.0 {
            return "\(round(thousand*10)/10)K"
        }
        else {
            return "\(Int(number))"
        }
    }
}
extension Float {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
